Return-Path: <linux-fsdevel+bounces-56684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7A4B1A95F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 21:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E150918A012B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 19:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE925DD07;
	Mon,  4 Aug 2025 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="I2SBtPqC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2E10942
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754334590; cv=none; b=FYsRwPY+OSWND9OlyT0OC1IU9xCezHsWClCOX9wvf63toW120WkC+BTJE2C5VAYQXPGdNEpgcwBnv5XRCNPaUgatIRvfmNazH8jD3jxxkq7EYgJpcMaSqwEiLROaiL3pG/4YUgxCQgdGWIo39Mx4Z4eWahBWwaa+0lO72LkiKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754334590; c=relaxed/simple;
	bh=EoqfN+RU6ie7d3cK9su2M9aANqfgOvgis4RwAsxwdIM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuNelKXiVSXQgfuSz7qBWAjmwhaeSbVXzk59l3WI5YKbSFO5W7XBVE1MBvKIRKJKrbOwWGkJf7Cq8xVo0eY5gasUjDKfHNEeGNhxhydRNYs/d42iir23tUyWsfZ3OTLzD8VgTER6EI5ZMV1N8p5Ndi2/plBMTEoBtj0MK+QEwL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=I2SBtPqC; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574J4F7n014745
	for <linux-fsdevel@vger.kernel.org>; Mon, 4 Aug 2025 12:09:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=CVr4dJoT4GG1Eomf8VBL
	A90t/VLrfXOEcI7JaT4XHqY=; b=I2SBtPqCUgL0pwVPlPkWHU0H827lpFozbzti
	SOYdRsT9nxB5OYHVTDAze1tWxuKLL9R2PkqDr6JwMgpcmqe7n7W2pnxIVAX4Y8HB
	nylx8C96ZRUx0NCGXn3zuu37Szz6lfZSkV/RptDf0YioVBnmvGHBfp83xo8ghQPk
	7yf1pn1Hf573fOWcWS32gnXcq8NYRjTkXwedSoLIbAd5mTGtT0kfHsrgM826jbD1
	U+v0ITxOOIHi4jIKoB2ZppFCcyckG9MPpHXMs0j787+XxVDNAkKW0Wx52J5Yjf8y
	vKKaMbJFbpCAF4C9p83zGAgiSTNg2vlxIJCugD+wY9QdpDL7Ag==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48ar4gcc5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 12:09:48 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Mon, 4 Aug 2025 19:09:46 +0000
Received: by devgpu013.nha3.facebook.com (Postfix, from userid 199522)
	id B3564654B2F; Mon,  4 Aug 2025 12:09:33 -0700 (PDT)
Date: Mon, 4 Aug 2025 12:09:33 -0700
From: Alex Mastro <amastro@fb.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
        Keith
 Busch <kbusch@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>
Subject: Re: [PATCH v3] vfio/pci: print vfio-device syspath to fdinfo
Message-ID: <aJEFbQgzfY6nf5Lc@devgpu013.nha3.facebook.com>
References: <20250801-show-fdinfo-v3-1-165dfcab89b9@fb.com>
 <20250804102559.5f1e8bcf.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250804102559.5f1e8bcf.alex.williamson@redhat.com>
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: _g7fo8gEgd7BaweYXucjusXcD8mLokdz
X-Proofpoint-GUID: _g7fo8gEgd7BaweYXucjusXcD8mLokdz
X-Authority-Analysis: v=2.4 cv=bM0WIO+Z c=1 sm=1 tr=0 ts=6891057c cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=j2pstE2d10wfqDpL5AwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDExMSBTYWx0ZWRfX5BD9mnNQE+XT YSVUmDzlN5XcISOVO062qTFsPu6NV4RYpzf34KZ2rVSvimBaP41fUOidQD7FdYYXV5FcJ8F0fW7 MzJhrCYdBjoGq4TCh0VID/4zU/SJuh8rKSZ5mwVg7dxocFfYLlOZkeEchZOkKMSfJzHar8BFroj
 mJD/RoSfSDW7KA3HT0KqZ0jXCoudZ29sw2lSbWdfOsuGvGJmdMla4dMe59fJsvY9u5A1lgUOl7F 5n+neyT/ByMeC4dqp/4aVZ72kjw7yrkMa5XW6yFoFlYp4Wjqdix9dE7aypD2Uhj+WkU3pNASnd7 8/ETkTUc96yri03yVm23VT9fPFMeLlwOaJ2UfvqW+EMLEX8cDe9Z6WARoiAEvI2Hl5m9INY8PEF
 huQU1iT6wBH8X2seI3qVjktKcyqk8nUWsfDOYEAlzKVO1aX9774ezn61D5vR6oGl+eZ0W6qX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_08,2025-08-04_01,2025-03-28_01

On Mon, Aug 04, 2025 at 10:25:59AM -0600, Alex Williamson wrote:
> Changes in this file look spurious, vfio_device_ops vs
> vfio_device_fops?  Nothing implements or consumes the vfio_device_ops
> callback here.

Agh. Yes. I missed removing this. Fixing in v4.

