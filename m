Return-Path: <linux-fsdevel+bounces-21100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593BA8FE3AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 11:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D523228774B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F76E181BAE;
	Thu,  6 Jun 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QKw0wDIB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA58180A93
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667973; cv=none; b=PXrmElSw+hr5lVgklEnmDsyl389qZOWji6NLMtXpVEVEjCe5xBXsg2ZNsvqMdKWOmAWPnzrH59F4mUYqQSfWuGAye1oyv4+JzWm12hg8W3iOvMYyJo6CYX4YLSGDVMsHiCrHRpHqQXg+94ERYQWB8gplJwOLr8JMbSb3g3wBb4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667973; c=relaxed/simple;
	bh=+kWRtm46EHgrfEjT1jHXAvldmafiXTrXdwgo0depAw8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=ui4B5rehfjSvQF0qtwmSn/NNLtVUv4PTE7SsVWjhri1NQIRaQ89QTQKY5ADG6hQ/1OiLClsgCsxS1FEft+8dK2bMpPJ/qcIi4aV4c1tdo4I6DNEU9s4cX6OhMY7seqV64/bYIISqJSBJCQ9Efj2Bd191al8mbLLWs8phjd2tNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QKw0wDIB; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240606095929epoutp03914dc71ef678d9b1927aae3826c8542b~WYesJiXHI0992609926epoutp03f
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 09:59:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240606095929epoutp03914dc71ef678d9b1927aae3826c8542b~WYesJiXHI0992609926epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717667970;
	bh=X/08X1olkAIHOusibyucFDGsWQxmM65XPCWbJyAP97k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QKw0wDIB92CTHYFpIxJAvP41i3DJ/cf/0ZXQkxIvg3jr4bqVBhe5VbL0CBZzrUrbE
	 VIsnKoi3ITrM41Z5pbK7a8XevDX5hsX25Fs2A4xZtx278nq37+lT2uXKtF7YrXjbk4
	 YCRlRNkc3u6DgyW/ZC5f8kM7jxZaEw/81EV7Z4xg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240606095929epcas5p245fe6bdf77b2f0f33a3edf73692d5856~WYerhxehs1456214562epcas5p21;
	Thu,  6 Jun 2024 09:59:29 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Vw0DH2hHwz4x9Px; Thu,  6 Jun
	2024 09:59:27 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A2.3C.19174.F7881666; Thu,  6 Jun 2024 18:59:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240606072827epcas5p285de8d4f3b0f6d3a87f8341414336b42~WWaz25d7o3006730067epcas5p2d;
	Thu,  6 Jun 2024 07:28:27 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240606072827epsmtrp28b89143fbe61df61e97e0db30931c9e8~WWaz1zddk3242132421epsmtrp2a;
	Thu,  6 Jun 2024 07:28:27 +0000 (GMT)
X-AuditID: b6c32a50-157f7a8000004ae6-62-6661887f9388
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C9.FC.07412.B1561666; Thu,  6 Jun 2024 16:28:27 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240606072823epsmtip2dad935b746ccadd32ea43752942abaab~WWawJjuEm2294122941epsmtip2Y;
	Thu,  6 Jun 2024 07:28:23 +0000 (GMT)
Date: Thu, 6 Jun 2024 12:58:35 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240606072835.a7hnqm5mkzvgsojp@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTZxjG951zetoSyo7A9APUscKygdw62/rhRIyiHnUzJGbZhltKVw4t
	AdquFxTHwn1yGchlw1EUOyRyKYEJjIGCY6CAVccWoIsYCyawTQFh3ibrKAMKi//98j7Pm+f7
	3jcvB3c1sT05cUodo1FKE/ikE9HW6+cXmJojjQ0pH+ahJnMfjjKKFnBkunuKRFO9jwAqm5vH
	0UT3SYBstwZx1NpnBWj8x3BkrDpLoNvdHRjqrCrBUJ3pGoYqTmdi6NriDIlKeiwATY4YMNQ1
	ugV9+0U1gTq7rhNo6NIZEp27MMlGNf12DBXnjGCofSIdoMapWQINjHqhwYV+1q6N9NDwIdpc
	BekOw102PWi9SNBDt/R0c30uSbdUp9J/tpQD+vLtNJI+X1jKogsyH5J0R/YYi/5rcpSgZ6+M
	kHRhaz2gbxqvsiPdouJ3KBhpDKPxZpQyVUycUh7GP3REskciEocIAgWhaBvfWylNZML4Ee9E
	Bu6LS1gaEN87SZqgXypFSrVafvDOHRqVXsd4K1RaXRifUcckqIXqIK00UatXyoOUjG67ICTk
	LdGSMTpe8aTIRKq/9Dg+cKeBSAP33PMAlwMpIczPyCbygBPHleoEsNGahS0LrtQjAEtmkhzC
	MwAvdBURax01RSPAIXQB+MvT31fbHwP43Pore9lFUL7wfG8+mQc4HJLaAm8scpbL7tSb8Nl4
	zYofp/pIWJ1VhC8LblQ0nDEXs5aZR+2BBWdqcQevg9fLJ1aSudTbcPFkJ9vxCgsX2upkDo6A
	P/xswhzsBh/0t656POHjh12kg4/Buq9qyeVgSGUBaPjNABxCOMw2n1oJwykFbLUMrDZvgl+b
	GzFH3QUW2CZWA3iwvXKNfWBDk3E1wANa/k5fZRr+O9DMckzlMgGtNhtWBDYbXviQ4YU8B2+H
	uXMZLMPSwHDKC9bYOQ70g02Xgo2AVQ88GbU2Uc7IRGpBoJI59v+aZarEZrByNf6R7cD03UJQ
	D8A4oAdADs535x3WSmJdeTHS5BOMRiXR6BMYbQ8QLW2oGPd8RaZaOjulTiIQhoYIxWKxMHSr
	WMDfwJvKPhvjSsmlOiaeYdSMZq0P43A907DoWmuA+l6OuOAb/5SL4fv50x+ZDoJX28osXp++
	FEU+sGtN3buD54z1zv6Efue2AIvQU+WzcXb6e5GGm60Yn5D46g8vJC/4RB3ENb5xf1QON93M
	cJluOnDUY778n/WFJ+wfXnV3OWBzvsMqed4bgaUlFUpSaKtH+v5NybobgfSY9T2/gNLP98pf
	rzmnqUjJP7JPJ1duDc2ZT/G4YiktbulIHuYmDSsTe40NyXszsbqyhdPzUevL7GW75zTeE7By
	PlV4vyKg0Nn22sgHn8h2rVM+/ezJ+23xH6c62ac4iy+bQSw/F5fdF232dfvpXXfp8TfE7q7e
	RxXpG7ww7lhzJ28mmE9oFVKBP67RSv8D5UMMgL4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxiGfc97enqoIzmU4l6EaDyZDmrsbLLha2SbupicBINTyBLFDc/k
	UAkUSEvdJNlkoKI0sPIRLaUbHxKLVUQBDShUUpRK1ZAMYaEOpFrkS2A1zoxMyiyNkX93nuu+
	nufPQ0PpC3I1nZaZI2gy+QyWkpA3utm1myIEPnWzsUuEm5w9EOcbFiC+NPwrhae7XwJ89u95
	iD1dhQD/97AP4taeEYBHb3+Ja+p+I/FQVzuBO+rKCHzx0l0CV50rIPDdxRkKl9kHAR4bMBG4
	07UR156qJ3FHZy+J+2+aKVx9YUyMLQ4fgUtPDxC4zfMLwFem50h8zxWB+xYcou2RXP+jOM5Z
	h7h207CY6xu5RnL9D3Vcs/UMxbXUH+cmWioBd2soj+LOl5SLuOKCWYprP/lExHnHXCQ3Zxug
	uJJWK+Ae1NwRfx16QBKbImSkHRU0n3xxSHJkwuASZdtW/Wh9biTyQKO0CATRiPkUWQwDoAhI
	aClzC6DGWgcVAOHowsIdGMih6KJvXBwoeQEqbdMTfkAyH6Hz3fq3Ak1TzEZ0f5H2j2VMFHo9
	aiH9fcg4KTRkNpF+EMocQjPOUpE/BzNfoWJzAwwsHYeoVf+KDIAQ1FvpWcqQiUG/t7ih/wBk
	IpDFt3QgiNmGFgs7xAbAmJYZpmWG6b1RA6AVhAvZWrVKfViZrcwUflBoebVWl6lSHM5SN4Ol
	h5BHtYGRap/CDgga2AGiISsLjtcmp0qDU/hjuYImK1mjyxC0dhBBk+yHwUpjVYqUUfE5Qrog
	ZAuad5Sgg1bnEeZoeVLfQfOa10mPd9fu4QcTbeky25a2+akdPZ1bp4yRzeV7w1hen7sfZmzu
	mGWFpsHkKce2GP2bj6uUCajCs5YdzUqSJwCQmkMbfGc863adiM0tPvqm4rPwyzNaw+RJvdnb
	0Ijmeo8h+QsVW1Fc+NTt/vyVybslMqxopXVn51DV+PxIdPKpEPw00cL/k6D0psf3mk9Xh8Bv
	bVv/ffC96PFfLnvKow3Pd4T9dFO0zq26bZ2t1zntsdUfRJUoLnfL9sU9a3kiv27P/c6RuvK+
	fPrn+fWJDVfzj5esgAd1aeJE4qVsMmdS4qbUVNKfBScs3xjjW59dG6zIU/yRX7aJJbVHeKUc
	arT8/7jiQ5l/AwAA
X-CMS-MailID: 20240606072827epcas5p285de8d4f3b0f6d3a87f8341414336b42
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_61518_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240606072827epcas5p285de8d4f3b0f6d3a87f8341414336b42
References: <20240520102033.9361-3-nj.shetty@samsung.com>
	<eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
	<9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
	<a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
	<665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
	<abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org>
	<20240601055931.GB5772@lst.de>
	<d7ae00c8-c038-4bed-937e-222251bc627a@acm.org>
	<20240604044042.GA29094@lst.de>
	<4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
	<CGME20240606072827epcas5p285de8d4f3b0f6d3a87f8341414336b42@epcas5p2.samsung.com>

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_61518_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 04/06/24 04:44AM, Bart Van Assche wrote:
>On 6/3/24 21:40, Christoph Hellwig wrote:
>>There is no requirement to process them synchronously, there is just
>>a requirement to preserve the order.  Note that my suggestion a few
>>arounds ago also included a copy id to match them up.  If we don't
>>need that I'm happy to leave it away.  If need it it to make stacking
>>drivers' lifes easier that suggestion still stands.
>
>Including an ID in REQ_OP_COPY_DST and REQ_OP_COPY_SRC operations sounds
>much better to me than abusing the merge infrastructure for combining
>these two operations into a single request. With the ID-based approach
>stacking drivers are allowed to process copy bios asynchronously and it
>is no longer necessary to activate merging for copy operations if
>merging is disabled (QUEUE_FLAG_NOMERGES).
>
Single request, with bio merging approach:
The current approach is to send a single request to driver,
which contains both destination and source information inside separate bios.
Do you have any different approach in mind ?

If we want to proceed with this single request based approach,
we need to merge the destination request with source BIOs at some point.
a. We chose to do it via plug approach.
b. Alternative I see is scheduler merging, but here we need some way to
hold the request which has destination info, until source bio is also
submitted.
c. Is there any other way, which I am missing here ?

Limitation of current plug based approach:
I missed the possibility of asynchronous submission by stacked device.
Since we enabled only dm-linear, we had synchronous submission till now
and our test cases worked fine.
But in future if we start enabling dm targets with asynchronous submission,
the current plug based approach won't work.
The case where Bart mentioned possibility of 2 different tasks sending
copy[1] and they are getting merged wrongly is valid in this case.
There will be corruption, copy ID approach can solve this wrong merging.

Copy ID based merging might preserve the order, but we still need the
copy destination request to wait for copy source bio to merge.

Copy ID approach:
We see 3 possibilities here:
1. No merging: If we include copy-id in src and dst bio, the bio's will get
submitted separately and reach to the driver as separate requests.
How do we plan to form a copy command in driver ?
2. Merging BIOs:
At some point we need to match the src bio with the dst bio and send this
information together to the driver. The current implementation.
This still does not solve the asynchronous submission problem, mentioned
above.
3. Chaining BIOs:
This won't work with stacked devices as there will be cloning, and hence
chain won't be maintained.

[1] https://lore.kernel.org/all/d7ae00c8-c038-4bed-937e-222251bc627a@acm.org/

Thank You,
Nitesh Shetty

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_61518_
Content-Type: text/plain; charset="utf-8"


------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_61518_--

