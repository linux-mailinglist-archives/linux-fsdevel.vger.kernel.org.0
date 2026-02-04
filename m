Return-Path: <linux-fsdevel+bounces-76239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPiUAH62gmnVYwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 04:01:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA36E119C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 04:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BDB930BECB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 03:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370D32DCF46;
	Wed,  4 Feb 2026 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JFLmvONT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE672DB7A0
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770174002; cv=pass; b=tt0BmOSFSNtp9R9MNeH8KiTTYFxK4MjNcYmM1q3HV29Sx2yMI9reBw4yc/jZfnhIzCOtp9buD+qUDVVhYbsiLsRjfZfjemtPjYDog1uXa7YYH7C5MZlcZaQbdqaXSKrjs/fa+/lHpyzAq6Ybc0VIfiMOosNuZiQFoxePIzZSg84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770174002; c=relaxed/simple;
	bh=kCQtGJA1J1ca1PYZnYNoeOv+iumuc90YwdUUifn6ZLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFLtIwf3MJj+m8NhAKnK7AOo3VG+FfmeA8zMb0BC37fVz6uzmXio6YCHb93iHFOx6VZI2jwGUSYWIeSHjI4Lsx4N8W6WDlyKQ7o2G0Kb64iJQ8KB/tx550/hGN/9lcUe4X/wdc5wz2JOd4x3L5lWCuPL+UvjV1k9NMpOsW1FBPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JFLmvONT; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so4037048a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 19:00:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770174001; cv=none;
        d=google.com; s=arc-20240605;
        b=DYUEO8z9OfHmeslWsVBWn+s3QeiDs3CcI121Ve6xtcAf7KPVEvNEyPKhM0qX19KYw7
         G1cfrJLBitl7TAB0Bvsto66MjqCq0pS1PSW8QBjGIBWfMDU7s+7DljuL51PXdsnXqVhM
         pXzjsosSCibe9FvmP8uFgy+AkFva+1IFMwB1bzmxh2p5E4FBWm5zgrMJTItBXetu6gTm
         O6yiZkYP6HnL2dhkrvxa9I+YZBE2ryt0IWn5TEFDBpEFmm/y1eRdmtZg8kIQhvpTU+ef
         4vGFUFEN8AlrSZQL04g7c+hMhOM5Ij4OXITYAxGjm3FWBkRp3fb/08xkykzAM2FgMaR2
         LsNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kCQtGJA1J1ca1PYZnYNoeOv+iumuc90YwdUUifn6ZLU=;
        fh=EKjBSE6A8pE/FJb3uk/d9cmpSbswKUDG2Uu+5bfIRdg=;
        b=TxfsnMgEoE3BwYFfeLyJ3VsGMlc0OXA6EJ3CsqENULNFPCoHsvZ8xLnL4H8XccYU/t
         mTFP+wSVu3jfB9AJ3UjW0+8+EpawXuKEvE9NwfJd96uTs5qfmLNx4q9TNxPZn/i1hslL
         tXnrbX+z1kVhW914kWjyynRZ9BYaWMj33ZbFrlhqYicOETDAekL9s7zoVdqc3AdfPuZy
         BWh4lnTmXPQg7/7BKGoJdJM8f/l9tagICTe3v1qcnJZ9ZFF8J18i18YPDpbWDs9XRWHg
         e8n2Yi2JA6wo/5xgKGWQiCAf/QP1SBB5EPb9qI9E7LZlkCkmm49GUtYUul6ry9Bj+27m
         b5NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770174001; x=1770778801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kCQtGJA1J1ca1PYZnYNoeOv+iumuc90YwdUUifn6ZLU=;
        b=JFLmvONTKcqupxVzUvIQL3YzlSnwmRVrL96PLk8ZOGEJpR3H+CyE8toP4hpxd6OQ4i
         QRuN8YJShgaXyZ7gFbYRQTDQPlN4BMCjFutRlQ3fGUj9ltSBGQxJOUSMBrO+ISsY7ZvW
         wGyW7Dgs/ulZE/heSWvNDw4x5CwGbLE1CiZzVeQY37EiX68taLuj6iEFIumx8cyfsNUv
         m2WjKGCD75yMJVOpeXhs5m5MJ0e3n3iBKCMRT6XgJGzjxqHwGFWU/1S7YZ1y/DOE9OHF
         aikIxkjrOltxI+uWV7JtosUb4m+g9ncJ0RYIrC8xlvEHPl2jwymPO83Yp5Aslkyk7L8p
         ps8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770174001; x=1770778801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCQtGJA1J1ca1PYZnYNoeOv+iumuc90YwdUUifn6ZLU=;
        b=N5DCPvJV8p2eH7jdgOXAMMcO/1jcMAb4/u7dsH2H1LON5GKgrEOtU0C2hLUXahMGCF
         ZqFJhMuc8+OoySpkgnMZv3y41p4sSHvDLRyG1Nxpjy/LmAOi6LPVfoFBA0ddhLZaY3cA
         ENo7H3rQOyyIOx3NCNM87z40MxKfUFJ1IJLUeQDiH5OrP2CzZTSByuEFe9idGACPiTl6
         jwQtSWSSkXxX1siZ3IwOpEbFYse56snfP7zJUUL1AituxRSp8VpRe4X4irpqmygh5Qy+
         TyRgOoSc2pbrrKSuHm2gCBoLp5o43M8m6ViAV0ZBoISwfj4YwTgCc+qsHCGYalwbj2TD
         TWZw==
X-Forwarded-Encrypted: i=1; AJvYcCWxxMujcGNAeSlsUheTRE6aJNLAFlnEmK3BFLCAdvuhkWmgP/qhs/QqNJJNvZFnYzKhB3zU5btAo7ie1s+B@vger.kernel.org
X-Gm-Message-State: AOJu0Yyal0qNTdbV5Lo3dFUhlpWYz1x/YEFZ1eWSpSH5a6008DJX3T4t
	eWP1atB9NRjyuZ+elvdQbLlP8/xCTvHLjTLBFZzSxTEhLBLEwFAW0VERAANBSiB8/6iMAbPlNxu
	giWrPZufBbkvW+gBb2bRFAo3i8LJq1jmsxJIJevEn3CBC3JWpNOxGQmyPSF1zNqs=
X-Gm-Gg: AZuq6aKP0sq3q3wleUhk/jjeznCbVGQTXEjgpKRbGxQSPngRQFUMwV0Nnyu/8EknBMD
	AfpgAc0oZP1vMX6J4JTIeCeqrmLoBtHSWRz8mZUAZoAEi3hkZp4eUkOL4YUG93YKW6OhvNUm5fc
	GZHCWGhryxLseKAwF7lQ7+nOcSwPN6/vbWLSUmPn3la9T/lLl/uENZIqw87q3eLUYNTEt8zz7vP
	15hsycHgTumRK/fKlbYnGMenoPCEACZZIuQ5C+WvvLIuWagKGryfuIz9YvHDzESFCZxHOHJ9CdW
	yQPSbP+fy0Q2
X-Received: by 2002:a05:6300:2206:b0:38e:87b6:a036 with SMTP id
 adf61e73a8af0-393724bf6f0mr1379799637.54.1770174000747; Tue, 03 Feb 2026
 19:00:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202120023.74357-1-zhangtianci.1997@bytedance.com> <4f66008e-228f-4e49-a860-314dd82116ad@bsbernd.com>
In-Reply-To: <4f66008e-228f-4e49-a860-314dd82116ad@bsbernd.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Wed, 4 Feb 2026 10:59:49 +0800
X-Gm-Features: AZwV_QjyMqKmvohZIX8OYC9o4SfwWGO5reH6hXBKxsy6SIV8hOGe4MlkfegqVOc
Message-ID: <CAP4dvsdaHNPuO2_ZLZ_8W-vPteR-Yyo67JhRrYuK67ZhvWkJrw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: send forget req when lookup outarg
 is invalid
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76239-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangtianci.1997@bytedance.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DA36E119C
X-Rspamd-Action: no action

Hi Bernd,

Thanks for your comments, I'll fix them and send the v2 patch later.

Thanks,
Tianci

