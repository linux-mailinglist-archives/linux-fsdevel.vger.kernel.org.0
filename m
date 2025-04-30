Return-Path: <linux-fsdevel+bounces-47741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E9AAA53CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B143B942A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 18:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5061026A098;
	Wed, 30 Apr 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b="OlLXSagP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta-outp-ksl-2.case.edu (mta-outp-ksl-2.case.edu [129.22.103.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF625D1FC
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=129.22.103.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038211; cv=pass; b=LktB5N3hYFUoBayOlL5WA7k8dcZ0tPVfbWoXJ/a7w7CJWWDdui8AzqjfTw7HcdbkCWOQqiFl/+omZikRMHakyXQkrFcPch6DtPLhH6qRKwakXmJpcCeerUSmHbc4GpqWPCWuZNEv3eQ8pTC/iQDoysFfOQx/n0GH3jkf71yRefE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038211; c=relaxed/simple;
	bh=EU6XUdX+aqjSGI5nezCzcOSTMPFuEyMvb8G98jawzGk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DkCxSdsZ3wXTURECvuTCowKPUWz82BsMRPRLjF/BdKFIpIk8DmGt+iAjV5AQqyo+UCGGL35hnlS8hXFQOWG4aEzte4ZCIzBxXshNYvOaWVT3XQqzbKM2dK3Fd7zHIGTF7msDYpzjya6Pmv3XyS0sVh9lS/q/vzOrQH4aqiHqlNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu; spf=pass smtp.mailfrom=case.edu; dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b=OlLXSagP; arc=pass smtp.client-ip=129.22.103.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=case.edu
Authentication-Results: mta-outp-ksl-2;
       spf=pass (mta-outp-ksl-2.case.edu: domain of case.edu designates 209.85.219.72 as permitted sender) smtp.mailfrom=case.edu ;
       dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case;
       dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu;
ARC-Filter: OpenARC Filter v1.0.0 mta-outp-ksl-2.case.edu D6A8C31000A9
Authentication-Results: mta-outp-ksl-2; arc=none smtp.remote-ip=129.22.103.196
ARC-Seal: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta; t=1746038208; cv=none;
	b=JJ0iIHEe3f+AZCeJOP6xlSBtvuy1D4WDZEMuo84SZ5QlFzapVxNG7kHrknECwUQt8IZar12uBudwQYuta2j8kc3TzDJHsZdjEM38nhE85TeF5hoVXNLjZ9vGdkZAgKDiWfYNzRN0DroGVj/utWBPwuQA8hnozh3Ubq64Hf8+cp57UNh4lO16RvwhwjyTbfV+UjuChDqCC9mcldcb7WHe5y10P71TP2Cto9wue20NDFrzs18A3J0w/TXGU/+vkkqLYQFdfyIJy/YGIww3viN4rVeKHdkDlfxCe6T9Yu0QpTVqRG42MJSgUHYvy9UqfPQEhUj8F7q0L0ZggSWLziLuow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta;
	t=1746038208; c=relaxed/simple;
	bh=EU6XUdX+aqjSGI5nezCzcOSTMPFuEyMvb8G98jawzGk=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From:to:
	 subject:message-id:date:from:mime-version:dkim-signature; b=WATuVBse7h+5jVWYP3+Y6yxQ5nHRikcu6Gy1hLytMlg5BXI9eGB5yrdU6PVz2jkhSFGBnzYNiEDbQ5eLbAZ+rTUk3T6FcziHikZj/vGuv0t9h/7dkLmwc98kFC6pm8J6CiC1ARbPjuDo+OyrSzHFdrH+6TUvver84UcJ09SZEUtt0rTHxHRRQqWogq/8LG4L8I3OuaJ7K3KFOK9mJRpFWUN3AgXdQevLvg5cddWzvM7Ym7/jbzEFg7do0pUstNxIbgaDKdD5f+WazLrCqwsX15JZQhmuod1c/UQAotRVF22cmGhU54PttX5rEpL3Zjm0Ew0+ayK/ZA7HNwJH+HcmKA==
ARC-Authentication-Results: i=1; mta-outp-ksl-2; spf=pass (mta-outp-ksl-2.case.edu: domain of case.edu designates 209.85.219.72 as permitted sender) smtp.mailfrom=case.edu; dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case; dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu
Received-SPF: Pass (mta-outp-ksl-2.case.edu: domain of case.edu designates 209.85.219.72 as permitted sender) client-ip=209.85.219.72
Received: from mpv-out-cfd-1.case.edu (mpv-out-cfd-1.case.edu [129.22.103.196])
	by mta-outp-ksl-2.case.edu (Postfix) with ESMTPS id D6A8C31000A9
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 14:36:48 -0400 (EDT)
Received: from mpv-in-cfd-1.case.edu (EHLO mpv-in-cfd-1.case.edu) ([129.22.103.211])
	by mpv-out-cfd-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id DDJ27654;
	Wed, 30 Apr 2025 14:36:40 -0400 (EDT)
Received: from mail-qv1-f72.google.com (EHLO mail-qv1-f72.google.com) ([209.85.219.72])
	by mpv-in-cfd-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id PDU47037;
	Wed, 30 Apr 2025 14:36:40 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6f2c7056506so3618506d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=case.edu; s=g-case; t=1746038199; x=1746642999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4A2sHSHRpt5kileLgP7Ygf59P4BM8A8KvqW9VICqQJ8=;
        b=OlLXSagPdf+Lgm3U1Q00YNbuTSji7y97kuNMPiIU7J3wr8xYebOEhq5fvzYpBkRwl6
         PfpmXM6/ljSzc2UWVzgvf9puohkERWOVZm7rHOnLA5uPt6HyVasREpegmwxB0YJMqXhT
         pbfBJtbD0r5/v9GMuLtGwCDsbucO4XDuWIfCpedK+wJKoNJgSvFLrW0PQRQPeHN9QQp6
         718RoA9OPZzO3OqftdJ85hjQG7CH5/CHW8BBRn0NpjgFNMIRgfjvOBCNj1z2hPfknARS
         Zs2HqNerVm7KsxoukoZ6H38GpMItfElSAVfwvGAtnuSHi+zVohzGVeGrn7BuWo4QKE/o
         Yp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746038199; x=1746642999;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4A2sHSHRpt5kileLgP7Ygf59P4BM8A8KvqW9VICqQJ8=;
        b=TMXi9/csWRS6QK/Ku94ubw2BG6GGgmO3yd+AyM4QCnlbybQCANrYw/1BH5KBq8MGk3
         flZ0lVEqgZVJtf/Nr6baLXRgIhXKJO5Hatrj8pgL/TPIej/NpKWMVIe43PONrUuqunx5
         FDSTRlmGYL3z2gMKAubuVJ4uTlpA6qYRBHbqb22YCnbygy2/nan9aLzlyQ6mwahWpPyw
         bKUbnwiahQc2CLuDWsE4VPock8EuV4YDYE8BB+wj2/DM4u2JmLgE8qT0kzJlnG5Nj6VS
         eZzWo7pqWxn/QYB8ZB/juJeVqjeQus87A0hy3gpUlrh6Z0ZjheSrd2JX4ULlh2Msia2r
         eIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXouJ/DnVIm+2U2sHilPaOn3sasMXMHxhqbrVv4MgJs1CJym+XhEryMmFrTrZ1Sk5VUw/rKhkkm1MQohZE/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1qygsyXRGJYYMbqH7wyx+l4EkUhRr91UXB3gr2UTVXE8MmAcA
	waMnedSW3Uom5yfodLtezbQGfZYvI3Dxpy7Ovih48USqowB5IFAzy1AEehCe3JQNSCZYs89C4xi
	rhJTft77B0KtwVOEr9m35sYagPVtOEOrYFlNsVR/hJPqaxMj83kIYBuLiltFMt0wv
X-Gm-Gg: ASbGncvFiu4Bcus7VJujhnta2Eu8cG+R6vYwluDSklgjH1Rh2hagBV6eODl9BlEXnSq
	c/TsZOrl9wLVxP5rh2T2N2Hb3uNWUV2UO2xxrVrFYVVAnJTIAMCFN5lxbrHmWjax+fqBH6YshAo
	nURN7N2+UzPOUy+cFrjysd4fNA8u00pMkQVx3flvMZB97H7Jw/i3+7UbAG4e5rJCWpUw0r8rF44
	qzUhe2+3dS8wJUMprZlVMyEf+KV+a/6WT5d8fUaCEn0CZDQpfWkIox25VwB3+tej48pP7BnVRxW
	ys4ydWnw9LnX015t8hElwylOnj0r4dpstTXeZOY=
X-Received: by 2002:a05:6214:2608:b0:6d8:ada3:26c9 with SMTP id 6a1803df08f44-6f4fce82c1cmr75630976d6.10.1746038199739;
        Wed, 30 Apr 2025 11:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH35qCABhwlYLbQIDwzv5bajwn1aPMXtEgjqFfvGVkAXgxHfM/i/R5Qp8C0mRFyalrWwP4+4w==
X-Received: by 2002:a05:6214:2608:b0:6d8:ada3:26c9 with SMTP id 6a1803df08f44-6f4fce82c1cmr75630596d6.10.1746038199357;
        Wed, 30 Apr 2025 11:36:39 -0700 (PDT)
Received: from [129.22.8.211] (caleb.INS.CWRU.Edu. [129.22.8.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4fe70a07esm11327886d6.57.2025.04.30.11.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 11:36:38 -0700 (PDT)
Message-ID: <b548ee65-3a54-43d7-aa6d-36e31cbf16f9@case.edu>
Date: Wed, 30 Apr 2025 14:36:37 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chet.ramey@case.edu
Cc: chet.ramey@case.edu, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Etienne Champetier <champetier.etienne@gmail.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org,
        openafs-devel@openafs.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs, bash: Fix open(O_CREAT) on an extant AFS file in a
 sticky dir
Content-Language: en-US
To: Jeffrey E Altman <jaltman@auristor.com>,
        David Howells <dhowells@redhat.com>
References: <473bad0c-9e38-4f8b-9939-c70c52890cd2@case.edu>
 <433928.1745944651@warthog.procyon.org.uk>
 <3d19dc03-72aa-46de-a6cc-4426cc84eb51@auristor.com>
 <666533.1746029681@warthog.procyon.org.uk>
 <8f6bd09c-c3d8-4142-938a-3fab5df7bd64@auristor.com>
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
In-Reply-To: <8f6bd09c-c3d8-4142-938a-3fab5df7bd64@auristor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mirapoint-Received-SPF: 209.85.219.72 mail-qv1-f72.google.com chet.ramey@case.edu 5 none
X-Mirapoint-Received-SPF: 129.22.103.211 mpv-in-cfd-1.case.edu chet.ramey@case.edu 5 none
X-Junkmail-Status: score=10/90, host=mpv-out-cfd-1.case.edu
X-Junkmail-Signature-Raw: score=unknown,
	refid=str=0001.0A002124.68126DC7.0039,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
	ip=0.0.0.0,
	so=2016-11-06 16:00:04,
	dmn=2013-03-21 17:37:32,
	mode=single engine
X-Junkmail-IWF: false

On 4/30/25 1:26 PM, Jeffrey E Altman wrote:
> On 4/30/2025 12:14 PM, David Howells wrote:
>> Chet Ramey <chet.ramey@case.edu> wrote:
>>
>>> Well, except for CMU's report.
>> Do you know of any link for that?  I'm guessing that is it was 1992, 
>> there may
>> be no online record of it.
>>
>> David
> 
> https://groups.google.com/g/gnu.bash.bug/c/6PPTfOgFdL4/m/2AQU-S1N76UJ?hl=en

Which of course just claims they reported it, but doesn't include the
report itself.

But Jeffrey's message seems to indicate that IBM addressed this particular
issue in AFS 3.2.

-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, UTech, CWRU    chet@case.edu    http://tiswww.cwru.edu/~chet/

