Return-Path: <linux-fsdevel+bounces-78443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG0mFabcn2nEeQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 06:39:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B93B81A112A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 06:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10A0A3063094
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A6538B7A4;
	Thu, 26 Feb 2026 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aqta6f3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A13387583
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772084366; cv=none; b=lDCQa8ls5u9xY7xFzOAUa9JxvFIm+/MwW5BUtx17tv+h66JL3XEuCKVTXg3gcGRXeCo6GasBc6r86v47Bk4A0iJf9IZwEKse/HCs20k1nB9uXclIER61JoWx+Sh0DmfiQfx2XDFUN0by1p+F6r/dkgPydzL9y1AuXpNYuy1dx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772084366; c=relaxed/simple;
	bh=98Jix/krbo6dyA/tVphqqw890oqNzxUKGYVBF718S2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnN6Ys0/2Md2T3CDVXjlLdLPYXDu3CxuhB1WwDUIwZTeaVULI23Q2Al9Bvphi14sKdTxRz97Y3JCr3R9lzpVOrGA7aOkVxxv4epy+8ypeZikcHgy75QxnddXfYBoONXiT/Mu8z+kDzpg96p2hjHtEgVEqwaObBnHM/tlOzCnvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aqta6f3n; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824a6f2d816so211291b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 21:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772084364; x=1772689164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=girr8DMXMUSfAHPIwlVf33ymX4RBl9Tpjk9js5kALNg=;
        b=Aqta6f3nUEeozut1bu4uEExxxuj0LC4aSIFscdG9uvLI4eGMMl5/S+s85aZglTCemE
         4R0yjyPgvtLUBiNMPC4nQcO/zZHqXGVyu4WOGQou15SWkW/wH7sIoo+HFZ+XMMZV8f8c
         YJgPDJlhGyqwbKemnIuZhFQjXxj7jFOy2IkaGIoUdTTRiYQTx8HJpi6XogksWclqEuFa
         C1AZwCJCzyFkV95R0ppBQ9H1F5zjzIcr+hdmN0SYrQBCOk5FsAs3eM49MxTnVcYgEUP7
         aJYhok2kzyA3gAnqNqZm3j570utbc9E4MlGkv9B7MOWpodnSysaIMI69K3u5+e2fk1P3
         JQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772084364; x=1772689164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=girr8DMXMUSfAHPIwlVf33ymX4RBl9Tpjk9js5kALNg=;
        b=a0DlpONllr3ajv0sGhYsfI3bVOfZSdiHXd1GLiGzPxsFbsfmuxnbTvSwIm30Iu4TA1
         /bO3q7GUNAPgYsW73008PRKk4QZmXO+WpHGMCl61e4naOvnMRg/gkWw18tBWxL+4GORY
         gFooLMjCw2tkna0CM4qoqr83Vn8rf0EIUU8zOW5s0ASNApFnnK4lZdQ5W5796f8zGN+L
         u9UUpDu2tKX7LbaQAOe8Sd6WoPK1ZJiZUVL3kfASptuzKf9drJ89VSmLw8EX0xhwhYOr
         0UC9iK96ENTH9Mjm6YPbbTpb6J53NG1hn9zjTfU164+46lwwTMh5fNEJy5vip0MyrWqR
         SjcA==
X-Forwarded-Encrypted: i=1; AJvYcCUXnLfmKLalGQnOP7TGi3qv9wmCGwUMMXHN1sCK4sX2JC6u/rA4L+FH41bnb/aJKWRF8xgkW70vYf+QE7Dg@vger.kernel.org
X-Gm-Message-State: AOJu0YyqeyNY14hT4f5nBwqOOkeMhSnjiYTTSyHSSGawGTH1mIRNCdh8
	alRYRWFLrp6JSBRXO2S3dDgDjUN9hqtny4AZP8hBudPi6jOcehhmiKns
X-Gm-Gg: ATEYQzzZXeo7QSpTuD3/EK6Y2/2ftc6ZzTvUFcNbmD8L7p7fiXoiN/HFCteuTBWW20c
	Hk60+xEXqI2t7Qve97hPL3uI69sjI2Qgz9UnIFAnqslM0nwb3fOzkLzKSqrNjvy+k4b4E97jt4+
	epO436IdSxOVApswaKwA3Mw4JnKNSwUxsYonT45cJg8xicn7k2ucRbhIBhRDDeiHRlea4yWTFOI
	vS9pRCNQdOkwYc/KgIQNU202gC0DtE/gm2229ENGt0X77HhRtX+zTd/997r2rH68y0Cz4RLLDd3
	P8d9hSmzwpVf9WCpZW4yl5dZapxTkMur6txcPLTsXXDe93OgAPE/pyg6LP1pBZeelrBBMnDsy0f
	cB90paBpAJK1kJiI89Yep/fVxHbPdOxGfraHmjBVS8yXF5A1QCOB+4Te2CvXEzE4b/wU4ekFJa4
	zsrg1fpLxJYfUVmw==
X-Received: by 2002:a05:6a00:9299:b0:7b8:8bfa:5e1e with SMTP id d2e1a72fcca58-8273bc94682mr1153931b3a.4.1772084363600;
        Wed, 25 Feb 2026 21:39:23 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8c5bdsm1094333b3a.19.2026.02.25.21.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 21:39:23 -0800 (PST)
Date: Thu, 26 Feb 2026 14:39:21 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ntfs: Replace ERR_PTR(0) with NULL
Message-ID: <aZ_ciVEhl-0PHfQ5@hyunchul-PC02>
References: <20260226040355.1974628-1-ethantidmore06@gmail.com>
 <20260226040355.1974628-2-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226040355.1974628-2-ethantidmore06@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78443-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hyclee@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B93B81A112A
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:03:54PM -0600, Ethan Tidmore wrote:
> The variable err is confirmed to be 0 and then never reassigned in the
> success path. The function then returns with ERR_PTR(err) which just
> equals NULL and can be misleading.
> 
> Detected by Smatch:
> fs/ntfs/namei.c:1091 ntfs_mkdir() warn:
> passing zero to 'ERR_PTR'
> 
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>

Looks good to me. Thanks for the patch.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index a21eeaec57b4..cecfaabfbfe7 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -1088,7 +1088,7 @@ static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	}
>  
>  	d_instantiate_new(dentry, VFS_I(ni));
> -	return ERR_PTR(err);
> +	return NULL;
>  }
>  
>  static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
> -- 
> 2.53.0
> 

-- 
Thanks,
Hyunchul

