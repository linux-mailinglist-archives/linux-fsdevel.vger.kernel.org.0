Return-Path: <linux-fsdevel+bounces-75995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMNbBqUYfmmMVgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 15:58:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AC4C29A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 15:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA70F3003826
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA83590AF;
	Sat, 31 Jan 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OvHzB4qP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ik1dSwSL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782393587C3
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769871510; cv=pass; b=MkqFFfeA59WtHbOsLAp/saINjUFB74xJC/QM19DccZszs4yfYEALh6gB5IsCHxekJhrgdW8uBqS6vRcDgYXthZeCUOam1y+1jce3TWrlLcbSslPR1b3w3IlFqT0e1VP9PhmRIZY8MQb6FYhIBRcDrxMeRfCMc74nuzLNLm1c+ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769871510; c=relaxed/simple;
	bh=XoPjc3FsSnhAH36Ksfm3BAJI9jxzPUWZyt5vdnTXd18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDEkN+2B6dzG9U3LMQL5eFqzgoaak6JMlG5SX4jzCMjX5AU6cYBY3vRW6+2btWeLQE9Zu7ypZKwBLn2s2qhz0JRH3sBlhyY4OLV8cSfDoE9R1G+cnpx8/XD1V897OhNPosM5S+l67IQBwH4lB+5vq4p4ZxGbnVnDloQSWRlqP2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OvHzB4qP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ik1dSwSL; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60V4U0lD447021
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 14:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=; b=OvHzB4qP/0jw0pjw
	qHWpKU9MTVgAy76IZFOwvomNtT5ojMnLFjv9vAMABxUYDDdhCdM/mdh/1U5ckbR1
	OHXys8Fv+a3PchmsefgHP4EyfqjCbDSoUrH0Z9vDG2TJsjY7dmvbMOIBYgB07cQC
	ID8YMzju3Vh/8MpgAyNwHRivnN+v5eYDr5CIhLCfTj2mGS4XRYyxzAUFh9cINBG3
	4lbqX8kwiPdpC2X1VC+X57Yc4hGnLxfwp4WoeziP1V7KW8OWpTYzBS2/84Kelkij
	c7Hl5zdRcBv8uYhTITx455LsNqpLBdwF+tnJlsXg2fGzqhfqDBQ8OAyarNxVhK3m
	+a43bA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1arrry48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 14:58:27 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-793b9a4787cso42209407b3.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 06:58:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769871507; cv=none;
        d=google.com; s=arc-20240605;
        b=bt9fXCNT5sn1whAakFhSK7Ry3BoF95lYy2l/iBpgMq/9KQbRrmhu1dUpirKxJPbPYm
         vQmdPt9AnLyG8a5koCXauMQ36+buSp4kcZRDYim+fY9VhVDtTJ++IHOrApZjBFZcbYEA
         SBrE5S0yDYtYwUbYZQnVs4Dy2BlFFi/lgiDwRtVeIpjjUrPCzTBoXLR7trOBs7P45OD3
         baUbbYMFAx/PlS+lYEtC1QGao2J0EQKlLDjbj7z1ZGVFnJgL+ebw6uP9LNcHUzlXr0ex
         m3hvrnn9/c0AorMr6qhnr5YEzOzujEYZ7xJHGmBCJkkoDEsyd+Se8IQ/VEkEJTz7EhT8
         qSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=;
        fh=fu0GU7lLkKEXc5SQIKZcP/nNrCKcLdZHY2Oh4A0h5qQ=;
        b=PJzG3wmhiu61u3xup7b6zQvhmi+sAfwakqGs2AVmJcwVs8g9qfqLDRhZ5HLvJF3jtC
         avYoSF+2SiousIk30bFNgB7RSAEh40ZhiS2tuS6VLlRpDphumAfF3DtpayPkNSS4S0VZ
         nlc/I5pecmEKhSCwjQ/c5+6JOikMDGXMRM8WYCTYDx2OTGXmX2QuY+g4DcnYqCTQweRb
         8Y5xj5a3bMoyuEE0JdHh91o4WXdsx08sPdxWZYLqAUklHHRrUdmlJiMauLPRXztdVnIx
         YCiwg55J9FCsJ5I2hrfWkwSI6MEQ8HWXXweyUM1ZRXqpsQ1srHneUezXrGlC44PXk9uD
         xF+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769871507; x=1770476307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=;
        b=ik1dSwSLQ5gKPr8itJihjb1p2ii6Z3jsGGCTSkLMElBTfrxMKk2BzSGAZs6Y3u/2Rm
         5Jc6JSviSstpkzoM62LilXKmZWvAB9DOuIyh5Gb+T0bn5eaFS/fm+ubSY0bwOoKcsOy0
         uUtdXIcMt8Yss89aVvVX6L4TWX7ziVDAwkZMGPY0zF71BzqoENGzauAVtQ4TysgmoZlo
         JTHS3Hq7Z/oREAC5DERRmVVlk1h39H69Q2dO8oZHQipUVCajubHib4a4IvOOCF6qUMnD
         V0QpB+SrFFffsYYxdEviApG9Tsmxy5nAA4c6446S0S+5+7eyl2juS3VlFK3vrM2U/7eF
         ejDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769871507; x=1770476307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=;
        b=Rt1VyL8orWxnBqQheREvEZCOPlwnvpk0azAUupTBPCiBftVe3rQ274IxrkLW8AjAwC
         uXCYA9RgErHVtm/9ShILX78xWYoY4uWgBIXbujLb+x4HbFn4rvENZzH2MLQZHlCye4XR
         zn0UaweoFBHU928j51K2iA6TvbHAT4/jHkD6Caf/EyKOkTrzdtPsXuv7h5yGGJS1xbim
         HfnhswrzMczKZFCurFjr72Jstv9dFUlvqARcqosRRqB0JGcWWwds9ii+8l/nb2rw8ImA
         3OxaIkWQHy3IFsnql8yifMHTcGiG/CMAJt0BcZyrlYjThJz1RSlWRjeeuAxzLbtBNI5h
         e9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbWyMfOTsJgK9pcxMtPWu/4UXa1BNuBKqRsiS9X9InXon/Kw71THc3F9z3bUghXSSoTds3ONjb9+HAAs0G@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4xAI9zvA8mL+WPLyC5tr5BL0pMzjU71eq6GAdoZ25Dzw3ANR
	8ALQEdG+OVlB68Saa8AAQSm7WYZQPfrwbWkFNi2UEv+jE5Y3X+2UV7wit7uQFZnvhYcmPGzHg9T
	ZcKFT8jg558zshBqg3d9H17ezaU0PaYa0ZuEjqmpCmLAcvgBDf7UYW2ww55pb186//EUSltHq4/
	YUM/xDNdTn1pWZx4GOhlJX1AJs6gIHCc9yICqkL1DHEqE=
X-Gm-Gg: AZuq6aKFZwmLVKdk6ii3m1Fl0F9XZEg2I53sZyA0ZSGW0LU7YoTS9Js1IXfnEI9m7lP
	giPY80ONfYhko7R4K/kHnVwzoNh29kfFij55tOAQ3B/lbqcan4TWVL2oG9IyIi3bv9WB1eQpUHr
	Jego8DhGXrzmzwKsSyNlrGFR+MdWFpMB1zZZI9zWmjns/ul22EeKtXnfBWCx5NTReIaQo=
X-Received: by 2002:a05:690e:4107:b0:649:7c5c:88e3 with SMTP id 956f58d0204a3-649a8547db8mr4403464d50.95.1769871506946;
        Sat, 31 Jan 2026 06:58:26 -0800 (PST)
X-Received: by 2002:a05:690e:4107:b0:649:7c5c:88e3 with SMTP id
 956f58d0204a3-649a8547db8mr4403441d50.95.1769871506570; Sat, 31 Jan 2026
 06:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV> <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
In-Reply-To: <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
Date: Sat, 31 Jan 2026 20:28:15 +0530
X-Gm-Features: AZwV_Qjt6-X-XbfNyo2_bleHjewtRG1qoA5gEXW9Hu9LjqRyKmxz-97xcVzcIio
Message-ID: <CAEiyvppoiL2EiSmVvNV3DEkr7wwyC1Fbwhm14h7Rfus4Z8uP7g@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Samuel Wu <wusamuel@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Greg KH <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu,
        neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org,
        linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com,
        linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
        selinux@vger.kernel.org, borntraeger@linux.ibm.com,
        bpf@vger.kernel.org, clm@meta.com,
        android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: SY4LatczBEqeQFJXf23l_s33rvt9IfhW
X-Authority-Analysis: v=2.4 cv=FNYWBuos c=1 sm=1 tr=0 ts=697e1893 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=1XWaLZrsAAAA:8 a=drOt6m5kAAAA:8 a=wEBb_YokH4NsbSDSc3AA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDEyNSBTYWx0ZWRfXzSQFr0tsWQM8
 Fmie13cMBoAFxOHdTOKv0OrecSAZIaqYolkV6p/sxSYMR/rFQm0S/AGwFvv+8ICHecvpD6KZQvV
 ejwrJLJIbBOyOOarvhcU4QlSlGRF1WTYC/T5A9zsjbjzxx0Ggbj0IQ1sQsL3k/Yb0t+LIWTEAC9
 h3tHmKZxCiCtrnRK0p/EcewjAyczJASZTlbvKHkfz3exDgh7n7ewImbNYOuTOl+CjVFW4ii149W
 Wpg+govOLV4byWokzA4lzL4xe5UPZV0rsKFrx9bzvpgNWrfNNXvp3sNx7C5m8Wb4zaL3papR76B
 MQzHMFZs/3cxAaaJhwOOLNlBRvT5igvAmXQNReB7J9AC1uZ4cRFtM4zsB75t+/r05nfm91zvua4
 yO4/zonvLYOX3tK8XLLwzCLNd8dFliosqfUm+wuZgyTzxHSo1yK6RIm5CbH2ofJi6l7M8mk77Uo
 9MGgtEzDqFl6mcKGfdA==
X-Proofpoint-GUID: SY4LatczBEqeQFJXf23l_s33rvt9IfhW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601310125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75995-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.kurapati@oss.qualcomm.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B2AC4C29A3
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 6:46=E2=80=AFAM Samuel Wu <wusamuel@google.com> wro=
te:
>
> On Thu, Jan 29, 2026 at 2:52=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
>

[...]

> I'm exploring a few other paths, but not having USB access makes
> traditional tools a bit difficult. One thing I'm rechecking and is
> worth mentioning is the lockdep below: it's been present for quite
> some time now, but I'm not sure if it would have some undesired
> interaction with your patch.
>
> [ BUG: Invalid wait context ]
> 6.18.0-rc5-mainline-maybe-dirty-4k
> -----------------------------
> irq/360-dwc3/352 is trying to lock:
> ffffff800792deb8 (&psy->extensions_sem){.+.+}-{3:3}, at:
> __power_supply_set_property+0x40/0x180
> other info that might help us debug this:
> context-{4:4}
> 1 lock held by irq/360-dwc3/352:
>  #0: ffffff8017bb98f0 (&gi->spinlock){....}-{2:2}, at:
> configfs_composite_suspend+0x28/0x68
> Call trace:
>  show_stack+0x18/0x28 (C)
>  __dump_stack+0x28/0x3c
>  dump_stack_lvl+0xac/0xf0
>  dump_stack+0x18/0x3c
>  __lock_acquire+0x794/0x2bec
>  lock_acquire+0x148/0x2cc
>  down_read+0x3c/0x194
>  __power_supply_set_property+0x40/0x180
>  power_supply_set_property+0x14/0x20
>  dwc3_gadget_vbus_draw+0x8c/0xcc
>  usb_gadget_vbus_draw+0x48/0x130
>  composite_suspend+0xcc/0xe4
>  configfs_composite_suspend+0x44/0x68
>  dwc3_thread_interrupt+0x8f8/0xc88
>  irq_thread_fn+0x48/0xa8
>  irq_thread+0x150/0x31c
>  kthread+0x150/0x280
>  ret_from_fork+0x10/0x20
>

Hi Samuel,

 Not sure if it helps, but Prashanth recently pushed a patch to
address this vbus_draw kernel panic:
 https://lore.kernel.org/all/20260129111403.3081730-1-prashanth.k@oss.qualc=
omm.com/

 Can you check if it fixes the above crash in vbus_draw.

Regards,
Krishna,

