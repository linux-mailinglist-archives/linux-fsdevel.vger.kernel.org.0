Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFE0269B58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 03:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIOBmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 21:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgIOBmB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:42:01 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128D8208DB;
        Tue, 15 Sep 2020 01:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600134121;
        bh=vFbfigDyjh6tM+is7U4CqnpknlTPj4S5BjRBKEyDgvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TolkzySW2dwMnO5Q7uDze9QJZpo15+SnjCZxRvfsoJtoQ6N7Gq/GLJCftwuTfwSWR
         mAc3+AV04FX6TObiphhTAe6JDrfOos/XsufDYgjtG/lJlKqPl8NUu/0HuAjl4P5Rk9
         uennl3yplnVQvPxYTcCqOa0bIkPZtWJO/Jo/Ub/U=
Date:   Mon, 14 Sep 2020 18:41:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 12/16] ceph: add encrypted fname handling to
 ceph_mdsc_build_path
Message-ID: <20200915014159.GK899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-13-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-13-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:17:03PM -0400, Jeff Layton wrote:
> +		} else {
> +			int err;
> +			struct fscrypt_name fname = { };
> +			int len;
> +			char buf[FSCRYPT_BASE64_CHARS(NAME_MAX)];
> +
> +			dget(parent);
> +			spin_unlock(&cur->d_lock);
> +
> +			err = fscrypt_setup_filename(d_inode(parent), &cur->d_name, 1, &fname);
> +			if (err) {
> +				dput(parent);
> +				dput(cur);
> +				return ERR_PTR(err);
> +			}

It's still not clear how no-key names are handled here (or if they are even
possible here).

> +
> +			/* base64 encode the encrypted name */
> +			len = fscrypt_base64_encode(fname.disk_name.name, fname.disk_name.len, buf);
> +			pos -= len;
> +			if (pos < 0) {
> +				dput(parent);
> +				fscrypt_free_filename(&fname);
> +				break;
> +			}
> +			memcpy(path + pos, buf, len);
> +			dout("non-ciphertext name = %.*s\n", len, buf);
> +			fscrypt_free_filename(&fname);

This says "non-ciphertext name", which suggest that it's a plaintext name.  But
actually it's a base64-encoded ciphertext name.

- Eric
