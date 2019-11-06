Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB28F0D1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 04:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfKFDgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 22:36:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59089 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbfKFDgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:36:00 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA63Zk2N030405
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Nov 2019 22:35:47 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 615B9420311; Tue,  5 Nov 2019 22:35:44 -0500 (EST)
Date:   Tue, 5 Nov 2019 22:35:44 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 1/3] fscrypt: add support for IV_INO_LBLK_64 policies
Message-ID: <20191106033544.GG26959@mit.edu>
References: <20191024215438.138489-1-ebiggers@kernel.org>
 <20191024215438.138489-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024215438.138489-2-ebiggers@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 02:54:36PM -0700, Eric Biggers wrote:
> @@ -83,6 +118,10 @@ bool fscrypt_supported_policy(const union fscrypt_policy *policy_u,
>  			return false;
>  		}
>  
> +		if ((policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) &&
> +		    !supported_iv_ino_lblk_64_policy(policy, inode))
> +			return false;
> +
>  		if (memchr_inv(policy->__reserved, 0,
>  			       sizeof(policy->__reserved))) {
>  			fscrypt_warn(inode,

fscrypt_supported_policy is getting more and more complicated, and
supported_iv_ino_lblk_64_policy calls a fs-supplied callback function,
etc.  And we need to use this every single time we need to set up an
inode.  Granted that compared to the crypto, even if it is ICE, it's
probably small beer --- but perhaps we should think about caching some
of what fscrypt_supported_policy does on a per-file system basis at
some point?

						- Ted
