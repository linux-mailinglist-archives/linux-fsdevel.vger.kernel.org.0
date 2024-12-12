Return-Path: <linux-fsdevel+bounces-37156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7849EE638
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933E6289F4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2871C2054E8;
	Thu, 12 Dec 2024 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eFIaujkn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A89C211A1E;
	Thu, 12 Dec 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734005077; cv=none; b=amolhHkyhOOnHyYMLyrUUa5gQADkQ+ut0W+aMmD6pSoXwvAJ6Lmp6HNWcxlzP4h0m6xXaqbzQR+kVW1kebWKhw9E+Hq+hwgBWJSTWcFZUttO32PMv2GdhXj+ZIpCxbIwLQrLKEf40t5BishD4rQM+dm6Jkpj9zjDG2TdCuEhEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734005077; c=relaxed/simple;
	bh=KwRUtSIOE3ICHpftNQ/HTVI772F1I/DyDYX6+C2fCzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvGtVmpkBGB0V3xGuUen4HtOC1KqgTOac3zdByXHePjm+B3Xyx7kyL/+pgSsKO5MubNXF1oejPdA2+gt98ApVgHpLfdh+n9miVg9H0NOwrKYCy4v+UF8vwROHcuCD91vllH5h2zEc3+0fPXPgAT9PrysCpyIFH5JkdA8PVGffgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eFIaujkn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC71xhD013689;
	Thu, 12 Dec 2024 12:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7yHd5RQSNMOR8sBMoRHceYCE9EWpOI
	2VaJRChNlQJb4=; b=eFIaujkn4iZXdh/7IMyPoZ0SH6dEFHFMcW2KZsLGvvE9SJ
	q9NLyboE+/2oRmX5439w+qAh3CD14Tgq0EyzpMnprNkKLPLj6PXwlGbkWGSEF/Gn
	hYhbKoN2NlDwIp9EHhjE3eeoT7dzynrTxQEkHUbDjikYyx47lrgPWiCy8C8/ZH5L
	KwhZyYRRzHNydIJi5Go8m+CSrn2DyKARlHrKOB9fpjppW4AW4ASZ3WIZYLIp3Jb/
	E8mk6jQQKpiV6oPWfnlY5I8il2BOvwSiJ74VbxPX5jKfN/JI9Fzd02YkzMTzJ4xR
	sRPA6VI+rWp0zW+qP2h2jDsTKWjPjYHkUSXSKnsA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce3942bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 12:04:25 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BCC0i6A024293;
	Thu, 12 Dec 2024 12:04:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce3942bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 12:04:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC9wQ3H017052;
	Thu, 12 Dec 2024 12:04:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12ygdd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 12:04:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCC4L0653150044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 12:04:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F7D320043;
	Thu, 12 Dec 2024 12:04:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B795020040;
	Thu, 12 Dec 2024 12:04:19 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Dec 2024 12:04:19 +0000 (GMT)
Date: Thu, 12 Dec 2024 17:34:17 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 3/3] xfs_io: add extsize command support
Message-ID: <Z1rRQdKs/9lHT6P7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <6448e3adc13eff8b152f7954c838eb9315c91574.1733902742.git.ojaswin@linux.ibm.com>
 <20241211181827.GC6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211181827.GC6678@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GSrzCAsn8t8FHV6td7E3DiUVpW-1sHoo
X-Proofpoint-ORIG-GUID: 9rr9lsXm6mqVBxotgved0ywWG8lSaqz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120086

On Wed, Dec 11, 2024 at 10:18:27AM -0800, Darrick J. Wong wrote:
> On Wed, Dec 11, 2024 at 01:24:04PM +0530, Ojaswin Mujoo wrote:
> > extsize command is currently only supported with XFS filesystem.
> > Lift this restriction now that ext4 is also supporting extsize hints.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Seems pretty straightforward to me.  Are you planning to add an extsize
> option to chattr?

Do you mean e2fsprogs? If so, then yes we'll add it there eventually
however for now I only have xfs_io patches since I was working on them 
to make the extsize xfstests work with ext4.

Regards,
ojaswin
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
> > ---
> >  io/open.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/io/open.c b/io/open.c
> > index a30dd89a1fd5..2582ff9b862e 100644
> > --- a/io/open.c
> > +++ b/io/open.c
> > @@ -997,7 +997,7 @@ open_init(void)
> >  	extsize_cmd.args = _("[-D | -R] [extsize]");
> >  	extsize_cmd.argmin = 0;
> >  	extsize_cmd.argmax = -1;
> > -	extsize_cmd.flags = CMD_NOMAP_OK;
> > +	extsize_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
> >  	extsize_cmd.oneline =
> >  		_("get/set preferred extent size (in bytes) for the open file");
> >  	extsize_cmd.help = extsize_help;
> > -- 
> > 2.43.5
> > 
> > 

