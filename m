Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848F6110FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 03:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfEBBwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 21:52:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44398 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfEBBwR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 21:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xNjOP9gg2QMy4x3ICBZoOoeoO4NbjsoS8XWQ33F0y5I=; b=e1Cdnr7Mt+nZArvTOHcIt/dcH
        Ie+TXMWhFAYA5HNxT+y63lHRcgthMLNLL/PSs84r2uhvCLp73HMv7fZ+6i58oeYNTdQzpVsYqdBF3
        nSsIM/r501mqjtAIkshkaSAWXLi3+lfbyh811CpB3RgxxHaVYJa6loRHloXhQ1iJ/dbbmb3AJHj1t
        pj+KBXXwUGZS7zTl5dGTlNJJTY1q4Id6eY+DUeLIZg2fShSdrsNHDR9dS/jmOXHnDsJZoKQLz3Qn1
        j4DV7gXZmiWBaXasQ1mnVROZhkNd7/lbqMTeCiyj5EpOonGLtzfwRwoMya+eznp6sO5aOwOgMiYnW
        PWVOs2XIQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hM0tT-0005DI-4W; Thu, 02 May 2019 01:52:15 +0000
Date:   Wed, 1 May 2019 18:52:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Direct block mapping through fs for device
Message-ID: <20190502015214.GB8099@bombadil.infradead.org>
References: <20190426013814.GB3350@redhat.com>
 <20190426062816.GG1454@dread.disaster.area>
 <20190426152044.GB13360@redhat.com>
 <20190427012516.GH1454@dread.disaster.area>
 <20190429132643.GB3036@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429132643.GB3036@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 09:26:45AM -0400, Jerome Glisse wrote:
> This is a filesystem opt-in feature if a given filesystem do not want
> to implement it then just do not implement it and it will use page
> cache. It is not mandatory i am not forcing anyone. The first reasons
> for those are not filesystem but mmap of device file. But as LSF/MM
> is up i thought it would be a good time to maybe propose that for file-
> system too. If you do not want that for your filesystem then just NAK
> any patch that add that to filesystem you care about.

No.  This is stupid, broken, and wrong.  I know we already have
application-visible differences between filesystems, and every single one
of those is a bug.  They may be hard bugs to fix, they may be bugs that we
feel like we can't fix, they may never be fixed.  But they are all bugs.

Applications should be able to work on any Linux filesystem without
having to care what it is.  Code has a tendency to far outlive its
authors expectations (and indeed sometimes its authors).  If 'tar' had
an #ifdef XFS / #elsif EXT4 / #elsif BTRFS / ... #endif, that would be
awful.

We need the same semantics across all major filesystems.  Anything else
is us making application developers lives harder than necessary, and
that's unacceptable.
