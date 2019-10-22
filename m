Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C73DCE0538
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 15:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388435AbfJVNhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 09:37:32 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59244 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388388AbfJVNhc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:37:32 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9MDbIXp024473
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 09:37:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 52E2C420456; Tue, 22 Oct 2019 09:37:16 -0400 (EDT)
Date:   Tue, 22 Oct 2019 09:37:16 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] ext4: add support for INLINE_CRYPT_OPTIMIZED
 encryption policies
Message-ID: <20191022133716.GB23268@mit.edu>
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021230355.23136-3-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:03:54PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> INLINE_CRYPT_OPTIMIZED encryption policies have special requirements
> from the filesystem:
> 
> - Inode numbers must never change, even if the filesystem is resized
> - Inode numbers must be <= 32 bits
> - File logical block numbers must be <= 32 bits

You need to guarantee more than this; you also need to guarantee that
the logical block number may not change.  Fortunately, because the
original per-file key scheme used a logical block tweak, we've
prohibited this already, and we didn't relax this restriction for
files encrpyted using DIRECT_KEY.  So it's a requirement which we
already meet, but we should document this requirement explicitly ---
both here and also in Documentations/filesystems/fscrypt.rst.

Otherwise, looks good.  Feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
