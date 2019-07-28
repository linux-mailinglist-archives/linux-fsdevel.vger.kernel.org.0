Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3843781C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2019 23:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfG1VWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jul 2019 17:22:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36306 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726103AbfG1VWt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jul 2019 17:22:49 -0400
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6SLMSdP012995
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Jul 2019 17:22:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F22684202F5; Sun, 28 Jul 2019 17:22:26 -0400 (EDT)
Date:   Sun, 28 Jul 2019 17:22:26 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 11/16] fscrypt: allow unprivileged users to add/remove
 keys for v2 policies
Message-ID: <20190728212226.GL6088@mit.edu>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-12-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726224141.14044-12-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:41:36PM -0700, Eric Biggers wrote:
> diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
> index 56e085c2ed8c6..307533d4d7c51 100644
> --- a/fs/crypto/keyring.c
> +++ b/fs/crypto/keyring.c
> +		if (mk->mk_users->keys.nr_leaves_on_tree != 0) {
> +			/*
> +			 * Other users have still added the key too.  We removed
> +			 * the current user's usage of the key if there was one,
> +			 * but we still can't remove the key itself.
> +			 */
> +			err = -EUSERS;
> +			up_write(&key->sem);
> +			goto out_put_key;

I commented about this on an earlier patch, but I'm not convinced we
should be returning EUSERS here.  Returning success might be a better
choice.

					- Ted
