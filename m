Return-Path: <linux-fsdevel+bounces-77124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIKdNVr+jmmOGwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:35:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 209AA1351F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3754304A6D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D5C34DCD7;
	Fri, 13 Feb 2026 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvQDHmuG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D1F9C0
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770978900; cv=none; b=s3+hNpBfjFtYfHsVICrCHZktq4hoGkMzBTL6eqWK1mqyeiLIE6sdxSt5sJK7lvE+Wm5yAsKmGhkDIuZGSSpNXoC8LmvXOC50Wsis/hCxWyHQsOhrSxAzijyIq0wqHDtcWGQEZOu3lmfZfymwZYsk2nYE3nUFwbhP4Z0RrYObj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770978900; c=relaxed/simple;
	bh=vhsH9mtau4Uz2YG/+Z0LgY0/5RXOh+YijD4TJlExTtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqfTvaAuKQw+BgrG6s5ftk5rv+GprUj02c0zYQouLQ02OSPvRTKKnN62BClk01anlDvuNH8oa0ZBvCF7od//VEWIuwW7ckSv/2dfP3Y2xeuJhDDkN2bhbLK6OKDFyDfQSdbtBxegl9WMBhtvj36fXahdwnYwDMDjpdh4dFuLVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvQDHmuG; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48371bb515eso6211155e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 02:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770978898; x=1771583698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huhmJuBCDaJLhpU5/7i3Q5nwShl4MBS9pZW3ziMh3Gw=;
        b=UvQDHmuGy5nNxSBzHDKswfQMJg4EGSUO7Vxp3uVKj3VR03HPgbaHSi1OlKjiLMxIuB
         1c2o2y+PvrPepFOm9TFcM2WvNaXpmnTL+Q+nrVc9wjrY9JG1MFIn4XzFsaYEpUyeVFbq
         nohwHC1f2OfHxDkSRHAGX9Vwi+CUeMhE+XX13REfrdI3CbKOIQmC9xfmGlWWeOZEfWcF
         04PRudoz8NnNH1pvYkiPMp02RSuIgs9L7iOPSb3HmvjUI+xoxzd07xi8ZRHcLBqmlHa6
         OGuqi5IuVrPGCKLSXaBt4L2OC5ZmWIfoQB0EL3xs8QG/+3up2a7RmO7yJ2a3GORZ26fn
         +jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770978898; x=1771583698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=huhmJuBCDaJLhpU5/7i3Q5nwShl4MBS9pZW3ziMh3Gw=;
        b=YxeV0AtJim6lzwhjPVcjjFZaRyVfeznhAElFafflCDw+Ay4pz/N0somzt8+bv/OV/L
         eIeKs4tEYkYS+QFGkYqsqausWOiXmZeKGAN203jfCLE2hzxOOQwG9Izj7yLVnMLSynep
         f0Tdmh5u6gJZFrjaa5A5PZxF2bjMmUaEDYJKALoqf1v97Me/bz2NCbn7YLrRqmwDXreU
         AXL9+O20v4gvdEXZm51/YQBrJV3c4UVVAgsJ/PerzA3gLv28GUkET3VOOMhUFhjIHAwN
         SLQVuGX+YJkJbqpyRdpbqdEvF3cXfNR3mnsvVTrbYRUKtt7yeAdxFTQ9IrK+Oqvh7zIW
         cW8w==
X-Forwarded-Encrypted: i=1; AJvYcCVBY3am0kC8ieCblWs3MFjprhEuVjWRCN6IdZmbyvXDBR83HVKocGsm5ACGE/sbyoiAcv+XmMW7Vs74J8gt@vger.kernel.org
X-Gm-Message-State: AOJu0YwYamU3RF92D9LXirfthV+Z9U1uO3aBw4euLoRnRYlT6nOAv1Om
	9M3sL2XRPdOcyF9q0Ewd43sbMcsowXpDGZDvzN5btMaIpMyP9OULZnvG
X-Gm-Gg: AZuq6aK/VtwT553sD1tR2qgQCSmaXtw6JC3Fe69Tf8eJiJqPcTCSAiJdSYjW4FLku9L
	Ed1Ueqp+D03emNhk3VaeLkA0zpfMUPHEeDTlvv3LTWdJIhOX057OjweYGQaq7ANMUbqug/hxHDl
	T88TT4nZmIkL+0HA4Wb4Ue8gy4N9xKvGFV124SsC/zgoIRT48qLUbRX5IQOkXTTIqZWuGrcbeNs
	9pPZl0W2bkWb3FrYKvwa++E8vDzBDXqaiNFt9ORXJPJk/zmmjaKwj6aPzbGKzrl/iByvLqhSqbd
	KcTjtYkdyXLgqwmBQf9PnQYLTvhhrO9USyPrlxOtuqdhxBm1RnyvCemFn5TjfGvW4OZvbXKJvap
	uzt/8cf9y6Cg1rNhVkXQmvPlA1oyWCUmJDCFJFEs/3DpYErPC+mOQ6bkbN6nDxqZawmISMTZKlh
	mVxyGPhagUhzkdzYX2Ni7qVIpBrTJgDnwJShBUQREkf+QEZb5XXujJNJch85E1
X-Received: by 2002:a05:600c:5246:b0:483:71f7:2782 with SMTP id 5b1f17b1804b1-48373a14406mr21442465e9.12.1770978897621;
        Fri, 13 Feb 2026 02:34:57 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8d46sm5118594f8f.32.2026.02.13.02.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:34:57 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: b.sachdev1904@gmail.com
Cc: avagin@gmail.com,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ptikhomirov@virtuozzo.com,
	syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com,
	viro@zeniv.linux.org.uk,
	wangqing7171@gmail.com
Subject: Re: Re: [PATCH] statmount: Fix the null-ptr-deref in do_statmount()
Date: Fri, 13 Feb 2026 18:34:48 +0800
Message-Id: <20260213103448.2474564-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DGDQFGJLPLU0.19QNB0MQLITQO@gmail.com>
References: <DGDQFGJLPLU0.19QNB0MQLITQO@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.cz,vger.kernel.org,virtuozzo.com,syzkaller.appspotmail.com,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77124-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangqing7171@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,9e03a9535ea65f687a44];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 209AA1351F4
X-Rspamd-Action: no action

On Fri, 13 Feb 2026 at 17:38, "Bhavik Sachdev" <b.sachdev1904@gmail.com> wrote:
> Hey!
> I think the fix should be the following instead, AFAIU we don't want a
> call to an internal mount to succeed.
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a67cbe42746d..55152bf64785 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5678,6 +5678,8 @@ static int do_statmount(struct kstatmount *s, u64 mnt=
> _id, u64 mnt_ns_id,
> 
>                 s->mnt =3D mnt_file->f_path.mnt;
>                 ns =3D real_mount(s->mnt)->mnt_ns;
> +               if (IS_ERR(ns))
> +                       return -EINVAL;
>                 if (!ns)
>                         /*
>                          * We can't set mount point and mnt_ns_id since we =
> don't have a
> 
> Thanks,
> Bhavik

I had considered returning an error code before but finally decided to
not. Thank you for your suggestion, I agree with it and resend the patch
v3 [0].

[0] https://lore.kernel.org/all/20260213103006.2472569-1-wangqing7171@gmail.com/T/

Look forward to your review.

---
Thanks,
Qing

