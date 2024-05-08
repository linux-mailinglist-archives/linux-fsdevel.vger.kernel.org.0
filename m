Return-Path: <linux-fsdevel+bounces-18980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AC48BF3E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 02:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B86B20B32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 00:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D627FD;
	Wed,  8 May 2024 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kvxMcYpn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22723399;
	Wed,  8 May 2024 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715129894; cv=none; b=mCHW9Y3UoqNSSSzrrLueGJzX8zf3fTYa8s7CcayW8rMKH2kcbsI01N0iNM3pJh789sS5jsSwm69fJwLTyjEYNXeuamp7xwkWDNElx0HnjNp7qc4/Xaywc0OKIC3ccREGA6W7bJWNchOSw5vu8TooTazBiAHea5fW86LLVLIT2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715129894; c=relaxed/simple;
	bh=zjO/qPZcafCTW43IRe3RvW2IfTQeDhHD2HqaG05cbp8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QPiRQidEWPZiWhXpo+HXk0WVRUydIqAZ/CBomX80IOTLiX8mjTVS3berQ13rPd3wfDE0TSUhRNn8PYUPmhy++0v3hrAzuQn1MsLlIe+gxlmRiDtlV1ykMCweL9AUd5Q5FCMA/ie8mqPquTIFZMi+6BICXMaFY4w4mEh2/BpYM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kvxMcYpn; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1715129877; bh=VFAZlXGZGtSQpeEGdXcNHn4HmDGOh8o9jDMv4pQ+wOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kvxMcYpn4Sm3cpumepeJlH2fgkGZA9R/gkj9Ugv/PDOBRYzhgPho8W7NZ3bvFjXHn
	 FqsTfcWYRTAQuaJf5Vs90JEr/a9Cmj+uVblzXXGbtbfEv/ueMZZB9Byj1xiWrZcTQH
	 2RVBy8WmFU70YkV4dy26tqg8e7ttbMyn7nwSwfOw=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id C6691693; Wed, 08 May 2024 08:49:38 +0800
X-QQ-mid: xmsmtpt1715129378t6bmvqgo1
Message-ID: <tencent_6086EB12C2C654899D6EE16EF28C8727EC06@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQAFbobgONXpXt6X7weDy7PIUgvjt+Jrfn5G8s9PQyPiQL3OoV6D
	 T9i50X8xTCRECO39v1VJXwlCA2ci74RCn0uX3AjuLyVWaWN0/mwyxDiRf4kc9615CkfQpS1E3U0w
	 vN/WZZaOYbYgoP4IJ2VQwytzt7ZIsggV6vswxoVFZHGF8wWbtZXVobokwpJ+02eNwWKo4D2HsQ2b
	 fmd1mZxfc7I7FjMAahln38gv3qaR5HdSgCNInyqvtkVK/yIKF7FyTWucaCtuXaQE5GeuYtqL5ieB
	 PEZuPLoSR0Ri70EW9c60M1MqTJy+/UtrW7YJVTWvMVKchdBtVQW+LGYTeec+bA+lOGmqWm1mlYsm
	 BvHToCPdBI9ZnCXQxHhZiq0LmMJYYJm1vc8iKGP0+zIYzq/viThTg16DXHqDFX+9TIZwq14Ah+FM
	 Paj0bcnFLaGDaqbBF4AqLtmHyAjE82cMUei4DKrXc+m+MCzjCduuXxbMnMNPaMdfzZlflP4/0j0c
	 BU6Ot86bF7M4O1e4g+dBPr1x7goICGiSKzXAn62sg2ctmHIgIHiKPpGQSRCHRvad62bN/p2shRVt
	 5RmcD2nhlHovJGw0dPXGaizeoSzzy+DDRQrHQRpBkbDExmH4xUzELgLAdaF4G4CIqcuz95jQcpzH
	 EdZQKjm57Ezv2g3oOUn6zwaURCHE8ReeawPbdOdkUWlC495weLXxfsdPIuLIJiwl6TxAk5nZ+TTe
	 Jc8pIWsERKBiU/w1RWy0D3Bd3lm5dXJE5Yj9CSUbL2+5cjtFjFbBtG1nKKiJRSXVRE6dKt1fxTkz
	 9reoCZpbuPyChrhymKUPE0dU1/8wq/s0BN3WvBxLAs4VBtlVfk83udZiUsg2nzEtVAyR9ArzcKMJ
	 DAsQcNWMasWa7LDPhi1dxyO8nmps7JrKW8uZ+2FrMUeGrnr1ql5HTLo5JBiLt0A3bnB3UMkqDbar
	 i2pJA7UyCGNmLq62J+ZA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: kent.overstreet@linux.dev
Cc: bfoster@redhat.com,
	eadavis@qq.com,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bcachefs: fix oob in bch2_sb_clean_to_text
Date: Wed,  8 May 2024 08:49:39 +0800
X-OQ-MSGID: <20240508004938.3201113-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <x73mcz4gjzdmwlynj426sq34zj232wr2z2xjbjc4tkcdbfpegb@hr55sh6pn7ol>
References: <x73mcz4gjzdmwlynj426sq34zj232wr2z2xjbjc4tkcdbfpegb@hr55sh6pn7ol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 7 May 2024 10:14:22 -0400, Kent Overstreet wrote:
> > When got too small clean field, entry will never equal vstruct_end(&clean->field),
> > the dead loop resulted in out of bounds access.
> >
> > Fixes: 12bf93a429c9 ("bcachefs: Add .to_text() methods for all superblock sections")
> > Fixes: a37ad1a3aba9 ("bcachefs: sb-clean.c")
> > Reported-and-tested-by: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> I've already got a patch up for this - the validation was missing as
> well.
> 
> commit f39055220f6f98a180e3503fe05bbf9921c425c8
> Author: Kent Overstreet <kent.overstreet@linux.dev>
> Date:   Sun May 5 22:28:00 2024 -0400
> 
>     bcachefs: Add missing validation for superblock section clean
> 
>     We were forgetting to check for jset entries that overrun the end of the
>     section - both in validate and to_text(); to_text() needs to be safe for
>     types that fail to validate.
> 
>     Reported-by: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
>     Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
> index 35ca3f138de6..194e55b11137 100644
> --- a/fs/bcachefs/sb-clean.c
> +++ b/fs/bcachefs/sb-clean.c
> @@ -278,6 +278,17 @@ static int bch2_sb_clean_validate(struct bch_sb *sb,
>  		return -BCH_ERR_invalid_sb_clean;
>  	}
> 
> +	for (struct jset_entry *entry = clean->start;
> +	     entry != vstruct_end(&clean->field);
> +	     entry = vstruct_next(entry)) {
> +		if ((void *) vstruct_next(entry) > vstruct_end(&clean->field)) {
> +			prt_str(err, "entry type ");
> +			bch2_prt_jset_entry_type(err, le16_to_cpu(entry->type));
> +			prt_str(err, " overruns end of section");
> +			return -BCH_ERR_invalid_sb_clean;
> +		}
> +	}
> +
The original judgment here is sufficient, there is no need to add this section of inspection.
>  	return 0;
>  }
> 
> @@ -295,6 +306,9 @@ static void bch2_sb_clean_to_text(struct printbuf *out, struct bch_sb *sb,
>  	for (entry = clean->start;
>  	     entry != vstruct_end(&clean->field);
>  	     entry = vstruct_next(entry)) {
> +		if ((void *) vstruct_next(entry) > vstruct_end(&clean->field))
> +			break;
> +
The same check has already been done in bch2_sb_clean_validate(), so it is unnecessary to redo it here.
>  		if (entry->type == BCH_JSET_ENTRY_btree_keys &&
>  		    !entry->u64s)
>  			continue;


