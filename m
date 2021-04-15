Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36F4360330
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 09:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhDOHWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 03:22:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231215AbhDOHWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:22:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13F741MW035099;
        Thu, 15 Apr 2021 03:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=Ra8XZsRoPt3RWkSm6Y8Gra/xkXf+XdRa8cOlLiOVnHg=;
 b=dOB/a5DX4rJpVOp6IcsPIpwNPbGYDuEctJ+H9pCkE8f+YWFb47LTG4oy3vafO2eX+RBM
 xezsLhbHgnUXhD+yH6UO4OGi8yxcrZ6TMK2D1vxf5UI0KLfH5oGEKZTRtv1Xj1b8at3q
 tDiDSrViudKqmFlq+J85waGl2+0pYEMXc3JR2W+xHfH519kFTSVRiBj8gIw0krRUUihR
 YBZJcuGGXFUTmTeXG5WY+Cdh7v+Eo8Hp98J0+wFifj55N0pmus/85U14C5zRKlxvfNAr
 Ts5g2xJSBCPX+Fm93e9cN7VH7aRVM7b/LzLmtLyOA1kfZqa3M5sJzRCwBvGa9ntEhD5H qA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37xbpt6n4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 03:21:38 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13F77FlA026328;
        Thu, 15 Apr 2021 07:21:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 37u39hkqmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 07:21:36 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13F7LYIP32178432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 07:21:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB4C1A405B;
        Thu, 15 Apr 2021 07:21:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 984CCA4054;
        Thu, 15 Apr 2021 07:21:32 +0000 (GMT)
Received: from in.ibm.com (unknown [9.77.201.251])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 15 Apr 2021 07:21:32 +0000 (GMT)
Date:   Thu, 15 Apr 2021 12:51:30 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Chinner <david@fromorbit.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <20210415072130.GA1749436@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20210405054848.GA1077931@in.ibm.com>
 <20210406222807.GD1990290@dread.disaster.area>
 <20210415052300.GA1662898@in.ibm.com>
 <YHfjMyJuvXzJsg6T@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHfjMyJuvXzJsg6T@dhcp22.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VKGRN7T7mh92ZYIqW5F5x5qaTpneG2EP
X-Proofpoint-GUID: VKGRN7T7mh92ZYIqW5F5x5qaTpneG2EP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_02:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104150045
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 15, 2021 at 08:54:43AM +0200, Michal Hocko wrote:
> On Thu 15-04-21 10:53:00, Bharata B Rao wrote:
> > On Wed, Apr 07, 2021 at 08:28:07AM +1000, Dave Chinner wrote:
> > > 
> > > Another approach may be to identify filesystem types that do not
> > > need memcg awareness and feed that into alloc_super() to set/clear
> > > the SHRINKER_MEMCG_AWARE flag. This could be based on fstype - most
> > > virtual filesystems that expose system information do not really
> > > need full memcg awareness because they are generally only visible to
> > > a single memcg instance...
> > 
> > Would something like below be appropriate?
> 
> No. First of all you are defining yet another way to say
> SHRINKER_MEMCG_AWARE which is messy.

Ok.

> And secondly why would shmem, proc
> and ramfs be any special and they would be ok to opt out? There is no
> single word about that reasoning in your changelog.

Right, I am only checking if the suggestion given by David (see above)
is indeed this. There are a few other things to take care of
which I shall if the overall direction of the patch turns
out to be acceptable.

Regards,
Bharata.
