Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9F939BCFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 18:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhFDQXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 12:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231415AbhFDQXv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:23:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7ECB61405;
        Fri,  4 Jun 2021 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622823725;
        bh=xn5ZeMcRayu4wtKmfS44ZO8eZDtZJ7X1BNPhLvdFscA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3iL0bsoQhg6GddljyqUxX4xeNG6w7VNhf9ddnuBhnfpmo9PKNMJ5qPMhkH4dG1Rp
         AFrhyQx8J2n+tSOSG9C69EH6ekvzdD6phQ0Xl2OEfUa+nHt98p5+OQpdW4FGjEe0Fp
         1wYvXGfb1T2HELCDnsBeuUpueDrl2I5eXO1C4QrRIC/5HBMUbmo6u8JCWePMM6I0pL
         bhFTBUlPNIu3XHRJG+QGe7bBoz+q64gteJdAyceQiI+yliq+mh3bRNvMTzlf0ULk+3
         hNo5+vc0tOJd1XrbbrtBtoHWUo8bs5cfdCQ9kO437M66JkBLQmakWG0+PR6SvMZkaO
         BqL1APQz1+4xw==
Date:   Fri, 4 Jun 2021 09:22:03 -0700
From:   Ming Lin <mlin@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: adds NOSIGBUS extension to mmap()
Message-ID: <20210604162203.GA9562@ubuntu-server>
References: <1622792602-40459-1-git-send-email-mlin@kernel.org>
 <1622792602-40459-3-git-send-email-mlin@kernel.org>
 <20210604152407.ouchyfuxjvchfroe@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604152407.ouchyfuxjvchfroe@box>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 04, 2021 at 06:24:07PM +0300, Kirill A. Shutemov wrote:
> On Fri, Jun 04, 2021 at 12:43:22AM -0700, Ming Lin wrote:
> > Adds new flag MAP_NOSIGBUS of mmap() to specify the behavior of
> > "don't SIGBUS on fault". Right now, this flag is only allowed
> > for private mapping.
> 
> That's not what your use case asks for.

Simon explained the use case here: https://bit.ly/3wR85Lc

FYI, I copied here too.

------begin-------------------------------------------------------------------
Regarding the requirements for Wayland:

- The baseline requirement is being able to avoid SIGBUS for read-only mappings
  of shm files.
- Wayland clients can expand their shm files. However the compositor doesn't
  need to immediately access the new expanded region. The client will tell the
  compositor what the new shm file size is, and the compositor will re-map it.
- Ideally, MAP_NOSIGBUS would work on PROT_WRITE + MAP_SHARED mappings (of
  course, the no-SIGBUS behavior would be restricted to that mapping). The
  use-case is writing back to client buffers e.g. for screen capture. From the
  earlier discussions it seems like this would be complicated to implement.
  This means we'll need to come up with a new libwayland API to allow
  compositors to opt-in to the read-only mappings. This is sub-optimal but
  seems doable.
- Ideally, MAP_SIGBUS wouldn't be restricted to shm. There are use-cases for
  using it on ordinary files too, e.g. for sharing ICC profiles. But from the
  earlier replies it seems very unlikely that this will become possible, and
  making it work only on shm files would already be fantastic.
------end-------------------------------------------------------------------

> 
> SIGBUS can be generated for a number of reasons, not only on fault beyond
> end-of-file. vmf_error() would convert any errno, except ENOMEM to
> VM_FAULT_SIGBUS.
> 
> Do you want to ignore -EIO or -ENOSPC? I don't think so.
> 
> > For MAP_NOSIGBUS mapping, map in the zero page on read fault
> > or fill a freshly allocated page with zeroes on write fault.
> 
> I don't like the resulting semantics: if you had a read fault beyond EOF
> and got zero page, you will still see zero page even if the file grows.
> Yes, it's allowed by POSIX for MAP_PRIVATE to get out-of-sync with the
> file, but it's not what users used to.

Actually old version did support file grows.
https://github.com/minggr/linux/commit/77f3722b94ff33cafe0a72c1bf1b8fa374adb29f

We can support this if there is real use case.

> 
> It might be enough for the use case, but I would rather avoid one-user
> features.
