Return-Path: <linux-fsdevel+bounces-47735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 196E1AA5004
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 17:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354CB1C043BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 15:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46373248F59;
	Wed, 30 Apr 2025 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b="I4Dr7AYL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta-outp-cfd-2.case.edu (mta-outp-cfd-2.case.edu [129.22.103.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C0D1EB196
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=129.22.103.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026378; cv=pass; b=F4ywE0jbb6oB5G3UXyeYD8kO7QgIr6efmxUBkmTrej/1XSe3xMbY3szzfnE/TOIa6Ywh4uAlltGBzLPkYqEdfhZ3uVj4mX9V9UIoMJzK3hgzlAUAzrZ4G1G7xFJWY9CoSR6ewBmeKK7AewWQOv5avHsZiiNwhJcDUiVEcjk2dd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026378; c=relaxed/simple;
	bh=AzjcWtzCo+O8MqZEFAe+xbB7xQLkIglom2B10pFpT6o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pyV1ImidoyOwxZH1iZGMwaGzj0ObCepgTLMW8y8MaPVh50ORGYGn1tf3wl+WM+H0O5nYI+Snzzk/8AvzjIMGi+UaciAcinPzlhMptJdwavgPSDoUbYGO/kivFUFjAuIowXwjNak8UL0Vl30FLwXU/f3lKXMjZE1AFvxO2yRmC5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu; spf=pass smtp.mailfrom=case.edu; dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b=I4Dr7AYL; arc=pass smtp.client-ip=129.22.103.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=case.edu
Authentication-Results: mta-outp-cfd-2;
       spf=pass (mta-outp-cfd-2.case.edu: domain of case.edu designates 209.85.160.200 as permitted sender) smtp.mailfrom=case.edu ;
       dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case;
       dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu;
ARC-Filter: OpenARC Filter v1.0.0 mta-outp-cfd-2.case.edu 3DA883480571
Authentication-Results: mta-outp-cfd-2; arc=none smtp.remote-ip=129.22.103.228
ARC-Seal: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta; t=1746025789; cv=none;
	b=Ibil8GyTq6yxD0m2SHw1aMeoFqSx6vm+DGC9DydtmHMvIvcOAjvdtSisewv6w+7IsplmEDy8dqLhv3ShXeUSsjGmzVkSV4vo4Hd53KAZ0vYzg4JeFB3vRRGJz94ixZjMDKAuDRlCx/ukZTMugN/o28+gWw3o83DEhhxrltXOQXq69iw6KZ6hg6iAMLC5V8np8CC7ruCAjZi/1VtsFBn3eS0qlIY814DvsZaUyjmAPQC+AWScjb5q9BsKgmS80gLxYvqvAAVhuAtpKT2IqVgTD3hUEaHIsDoTbUG8fFInck/hMdIsrreYmKymmlECN9cZyTFsQs/QGFjkXfBfEniEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta;
	t=1746025789; c=relaxed/simple;
	bh=AzjcWtzCo+O8MqZEFAe+xbB7xQLkIglom2B10pFpT6o=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From:to:
	 subject:message-id:date:from:mime-version:dkim-signature; b=LjwyeTznc7BRPGA3e8fhFd9U4mWVtn8KDAc/dupUd7sUlloA7cNtkrWeuxo3qStJF8qGT1LF0LG+iVpx9IdxTwDCUffHZmTJ9MsXZKlEdT1WFcRg3kP0aroXb1lkq/XwGEhSk9c7Qx7nW+UFM2IWFq8hH6UZBSSA/8feVQD4WQbb4KWZbf6Wlv7a0HnpOPIHSENKW+RCXoYaVtWMfmYmv02ShxZp3sbt3ClQ93S+/+W/QP5+/zwhlTTqtcP+g+fmPCCfXs4lSpz2Fjxrnj7/PC6cEEsnsMkaJyPN0OMTo3jIu1pSVdpBYwjHEVSY1RemHHHmp/ljmNCuBcCpbdgqqA==
ARC-Authentication-Results: i=1; mta-outp-cfd-2; spf=pass (mta-outp-cfd-2.case.edu: domain of case.edu designates 209.85.160.200 as permitted sender) smtp.mailfrom=case.edu; dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case; dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu
Received-SPF: Pass (mta-outp-cfd-2.case.edu: domain of case.edu designates 209.85.160.200 as permitted sender) client-ip=209.85.160.200
Received: from mpv-out-ksl-1.case.edu (mpv-out-ksl-1.case.edu [129.22.103.228])
	by mta-outp-cfd-2.case.edu (Postfix) with ESMTPS id 3DA883480571
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 11:09:49 -0400 (EDT)
Received: from mpv-local-cfd-1.case.edu (EHLO mpv-local-cfd-1.case.edu) ([129.22.103.203])
	by mpv-out-ksl-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id DCB89993;
	Wed, 30 Apr 2025 11:09:48 -0400 (EDT)
Received: from mail-qt1-f200.google.com (EHLO mail-qt1-f200.google.com) ([209.85.160.200])
	by mpv-local-cfd-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id EHU28305;
	Wed, 30 Apr 2025 11:09:48 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4768656f608so130441051cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=case.edu; s=g-case; t=1746025788; x=1746630588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SlRUNotoyOPrZmtBHdOmGWaPKtm8Fs35t7kqSSKlfjM=;
        b=I4Dr7AYLMDxdkSVGt4mygoeL8/ANzESYNAuDv6mY+KY1Ool44oZN8VuRopFI2FDhBb
         asKGyCItta2OIXlvEkIFmBXhNljlVVIUHUbTlJ2gl/wejfOTwj6dN3BKyYXfds5UEQTS
         wCnQLST7uOy4C6se1+MZMmy7Rq3nnclkrj0CBE6Wtyq71C0j/WD1Jgo8t9mGTMRP1CaI
         zpQnvoh7Btc9uHuhS69ILIi+2ojINeNOVrcZBSkNBh4J5a5yR9A5FJp8a/4kxl1HkcLU
         PDmfQUV/tzdhNP0U1VUBI2yDB/geYDkcF0cfEqc5AsImCsfu1BPDhiGpHuGXD1s+SVTh
         /yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746025788; x=1746630588;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlRUNotoyOPrZmtBHdOmGWaPKtm8Fs35t7kqSSKlfjM=;
        b=KV//IERgaVZ7TSiPNaHJSNfyT9voNY46L0waeLru+0l0HotfW4SSwagl4JnjJPsBkG
         tReIHO3quuoiGLJ7RQBIzR6JVCmWHE+CjpEopD45k1S5nSvBELrtevnO9H3qBKMXYAsm
         E+Gs40zSMoSAsLTNxNWtTJjA2HwyB1s286AqHGeqysg16L/7ko02J+v4JwunY2WTNIo/
         1dLGWntcIV3VoztdTk8MZ02V7sluKyzn7cifUoE4VjRFEKoPt7xJoRPVMADoeSVDWHoY
         1JhDKVaZe+dqeuCzgOmQUAXWDRckgWhFTqSup6yaURJ2XXH3tKSUImaM6dTSLvaIjojG
         VdeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGumBzU9ZCCuTjYppgll28nG3eRHLaEOALlzdoIiLhw+/N6Wgzjpopd95Edl7vVmIqLkbaH+zOd06vPrfA@vger.kernel.org
X-Gm-Message-State: AOJu0YzdfUPzXP0biLi5YMowEX9njkDsHAmlO5Whw04rEGYt3WV5eDnv
	XvOkhAODv9JAJdAvqdAgPGMLp1oBm/Neu1bf/gLOPVWHxlw9pn3smcUIbiN6Qc0Y+BOeB3yfIdR
	wwZjyw/gMZ5NYBz/qRLfZg2ZHq7qcrsNpOhKPWjGWJ0JFFwwX/XVGSS6kIAf7dqni
X-Gm-Gg: ASbGncuDQrzzJJE95ae3hnLv3vAem1oHvIkiyo92YbhFfOe8HSGM2TUUmL670YQ7G1s
	+234QTPE/YJztcNwC7lpAai8xYigZnNoRYgg5B9UKNUrenlHtyosq7NenqlTF3EYxPDH+dMT2Ev
	S9D/lTUWjoo52YKpURqbsU5grtZR8cahfN5vx1RAC24S+DzueKjfYYhXpx01fau/xrvIvG9v5Ym
	jGOWNaPOAg1eLiU8XM3WZrbRzrtulMpmu0ZiV1jOvrg3NXODZPthrkQ9TPhzfVP8xX1XvJMfVs5
	7t5BogLohgj7HT+qP9LGwd6N78LgWVxtpajkVXo=
X-Received: by 2002:a05:622a:1f10:b0:477:1ee2:1260 with SMTP id d75a77b69052e-489c38ae0e4mr59729461cf.1.1746025787937;
        Wed, 30 Apr 2025 08:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwc3yOTaObmu1NRdEPUxNDIHKFCkwt05nWczHxLVmvt32NfqQFV7+6fNq30eCQf4mlEKzUXg==
X-Received: by 2002:a05:622a:1f10:b0:477:1ee2:1260 with SMTP id d75a77b69052e-489c38ae0e4mr59728861cf.1.1746025787490;
        Wed, 30 Apr 2025 08:09:47 -0700 (PDT)
Received: from [129.22.8.211] (caleb.INS.CWRU.Edu. [129.22.8.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f0d231csm94370501cf.29.2025.04.30.08.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 08:09:46 -0700 (PDT)
Message-ID: <473bad0c-9e38-4f8b-9939-c70c52890cd2@case.edu>
Date: Wed, 30 Apr 2025 11:09:44 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chet.ramey@case.edu
Cc: chet.ramey@case.edu, Etienne Champetier <champetier.etienne@gmail.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org,
        openafs-devel@openafs.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs, bash: Fix open(O_CREAT) on an extant AFS file in a
 sticky dir
Content-Language: en-US
To: Jeffrey E Altman <jaltman@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro
 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <433928.1745944651@warthog.procyon.org.uk>
 <3d19dc03-72aa-46de-a6cc-4426cc84eb51@auristor.com>
From: Chet Ramey <chet.ramey@case.edu>
Autocrypt: addr=chet.ramey@case.edu; keydata=
 xsDiBEEOsGwRBACFa0A1oa71HSZLWxAx0svXzhOZNQZOzqHmSuGOG92jIpQpr8DpvgRh40Yp
 AwdcXb8QG1J5yGAKeevNE1zCFaA725vGSdHUyypHouV0xoWwukYO6qlyyX+2BZU+okBUqoWQ
 koWxiYaCSfzB2Ln7pmdys1fJhcgBKf3VjWCjd2XJTwCgoFJOwyBFJdugjfwjSoRSwDOIMf0D
 /iQKqlWhIO1LGpMrGX0il0/x4zj0NAcSwAk7LaPZbN4UPjn5pqGEHBlf1+xDDQCkAoZ/VqES
 GZragl4VqJfxBr29Ag0UDvNbUbXoxQsARdero1M8GiAIRc50hj7HXFoERwenbNDJL86GPLAQ
 OTGOCa4W2o29nFfFjQrsrrYHzVtyA/9oyKvTeEMJ7NA3VJdWcmn7gOu0FxEmSNhSoV1T4vP2
 1Wf7f5niCCRKQLNyUy0wEApQi4tSysdz+AbgAc0b/bHYVzIf2uO2lIEZQNNt+3g2bmXgloWm
 W5fsm/di50Gm1l1Na63d3RZ00SeFQos6WEwLUHEB0yp6KXluXLLIZitEJM0gQ2hldCBSYW1l
 eSA8Y2hldC5yYW1leUBjYXNlLmVkdT7CYQQTEQIAIQIbAwYLCQgHAwIDFQIDAxYCAQIeAQIX
 gAUCRX3FIgIZAQAKCRC7WGnwZOp0q069AKCNDRn+zzN/AHbaynls/Lvq1kH/RQCgkLvF8bDs
 maUHSxSIPqzlGuKWDxbOwE0EQQ6wbxAEAJCukwDigRDPhAuI+lf+6P64lWanIFOXIndqhvU1
 3cDbQ/Wt5LwPzm2QTvd7F+fcHOgZ8KOFScbDpjJaRqwIybMTcIN0B2pBLX/C10W1aY+cUrXZ
 gXUGVISEMmpaP9v02auToo7XXVEHC+XLO9IU7/xaU98FL69l6/K4xeNSBRM/AAMHA/wNAmRB
 pcyK0+VggZ5esQaIP/LyolAm2qwcmrd3dZi+g24s7yjV0EUwvRP7xHRDQFgkAo6++QbuecU/
 J90lxrVnQwucZmfz9zgWDkT/MpfB/CNRSKLFjhYq2yHmHWT6vEjw9Ry/hF6Pc0oh1a62USdf
 aKAiim0nVxxQmPmiRvtCmcJJBBgRAgAJBQJBDrBvAhsMAAoJELtYafBk6nSr43AAn2ZZFQg8
 Gs/zUzvXMt7evaFqVTzcAJ0cHtKpP1i/4H4R9+OsYeQdxxWxTQ==
In-Reply-To: <3d19dc03-72aa-46de-a6cc-4426cc84eb51@auristor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mirapoint-Received-SPF: 209.85.160.200 mail-qt1-f200.google.com chet.ramey@case.edu 5 none
X-Mirapoint-Received-SPF: 129.22.103.203 mpv-local-cfd-1.case.edu chet.ramey@case.edu 5 none
X-Junkmail-Status: score=10/90, host=mpv-out-ksl-1.case.edu
X-Junkmail-Signature-Raw: score=unknown,
	refid=str=0001.0A002107.68123D37.0053,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
	ip=0.0.0.0,
	so=2016-11-06 16:00:04,
	dmn=2013-03-21 17:37:32,
	mode=single engine
X-Junkmail-IWF: false

On 4/29/25 1:35 PM, Jeffrey E Altman wrote:

> I think its worth clarifying the purpose of this fallback logic and why it 
> exists.  The fallback
> logic was added to bash 1.14.7 as part of the introduction of support for 
> IBM/Transarc AFS 3.4.

The chronology is wrong. The workaround came in in January, 1992, when
bash-1.11 was current and IBM released AFS 3.1. (The bug was actually
encountered with bash-1.08.)

The old code, without the workaround, caused widespread mail delivery
failures at CMU, who reported the problem to me and (they claimed at the
time) IBM, and provided the patch.


> It was noted that sometimes EEXIST would be returned from open(filename, 
> flags | O_CREAT)
> but would succeed if open(filename, flags & ~O_CREAT) was called.  There is 
> no evidence that
> the AFS developers were aware of the problem.

Well, except for CMU's report.

-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, UTech, CWRU    chet@case.edu    http://tiswww.cwru.edu/~chet/

