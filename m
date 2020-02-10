Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26915821A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBJSMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:12:07 -0500
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:60394 "EHLO
        mx0b-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgBJSMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:12:07 -0500
X-Greylist: delayed 616 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 13:12:06 EST
Received: from pps.filterd (m0075028.ppops.net [127.0.0.1])
        by mx0b-00003501.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AHsEtw013707
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 13:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com; h=mime-version : from
 : date : message-id : subject : to : cc : content-type :
 content-transfer-encoding; s=proofpoint;
 bh=Z8dA7ja0z0zhiql1ET4f/eGTFeiCfpiQ/bKG8w6YQ5M=;
 b=qaPz6Gmmr3DEUA5izcCk+LvthhWnEvaFylb5570EhkhpHhvOd/MTtVgx6UmgseW4RLDg
 2a9sMVWOQQebKwGFpEUe8/GJwNwLwoOFGdlgFVtohszdLlwJckltcLnZRaaWz0TYrpOP
 YUoPZRx+n4McnV6+vXG0jXAN/Ksw7ik5kXvxU87ro5CqvozAIZhWE0w+IOBiFoJJwITJ
 4aEukoezTVz5mzoe/mSKRu20Zv9Vqo5hyB3wzUt6BPWGJ9Wi6ngsCwxoOMHtF8jnTVl2
 0QB5c9oqF/K+LQ+2ffeVbv40hta5fixE2uIgTUD+YkQMRBEngeXRRp365w4gc1WKJ/O+ fg== 
Authentication-Results: seagate.com;
        dkim=pass header.d=seagate.com header.s=google
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        by mx0b-00003501.pphosted.com with ESMTP id 2y2avbefu3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 13:01:50 -0500
Received: by mail-yb1-f197.google.com with SMTP id q23so5418210ybq.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 10:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seagate.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Z8dA7ja0z0zhiql1ET4f/eGTFeiCfpiQ/bKG8w6YQ5M=;
        b=mHwqubgw8xQCm4Mbzw4x9eNo+nE33sE0ziwKfcirlJfD1h8txk2ldyLZQbTj+iPgZo
         Yq3NdESdGeYW3g0Ic25cuNvndSsZxpK1p+CRqKUQHguL2iYLXDTp/uNwzWCZYmi9K/ZE
         R+c7GL8l+i4WMjv215RGvupnSeXV8BBAVFECuKS0jIKtzyg3PTqGv0MPfmAEytUSuyGh
         dkeWQwr88DqRgtPFMe/LRhSl6jFNvZ1y/ul+UiuXbfjnYZa4RtlHY9OyYiWnYJQI3AjE
         +bKGvOYe385ehg9wuxAaKe160FRmbXPZOQteEZvrwkkgT+VzoZB2ubQStNoM3kdy9jn9
         iL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Z8dA7ja0z0zhiql1ET4f/eGTFeiCfpiQ/bKG8w6YQ5M=;
        b=ktD2SM1deBxE/ERW+EWXtmFpbcmjgFmf7mtk8JjT0ebZeF/BFGiJmnOojp90MgtGNY
         fw6bTc55q4JN2inawOgYjcVvgt6glJ8q3QaPGjCrlkBWYOCYoRjM/1AAbeiAQxgqirwj
         lEs37ilcZ3wRKK9MplVMq7bmortarBfp/XIiY2K6B0aWVHOKQyZUMi4pIOVVyHvxDcxP
         1FhbQdq0QAr/kbCfx7LeTOKSEWXonGYx2y2s+vXvc3w5tVqQjcvKh8Xdp5yTih8Yltyg
         laqgCsIbRRaZeRrAH4lRIrZ11LlXAr+uUk2zNEiarf6naN3OTFJ2ijM8Mw9NDmPWThHn
         vrEg==
X-Gm-Message-State: APjAAAUCFdMVXRFTzUuUNQzvwHNq+lgM9UWqOh1PTfA/RSF1M4mp/JEY
        hyC2GtBdnOPrKFau/BIgYAWHQpatMo/PHaF2XsR/JxhJVjolQIbh9nnAr6DkVqMsUxImhM08/jk
        uxevEJwdpY8m4Ne6a6bz15xXKpZDx3fPZ+ymVb+FeNl8SeAwLATwUGEBOBrvWYjlTlfk=
X-Received: by 2002:a81:b60d:: with SMTP id u13mr1947430ywh.382.1581357709428;
        Mon, 10 Feb 2020 10:01:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzzP96nNZW/MvJzPkPbq/hXLO/p50s4FvrFzDRw94dQxd/SVJksxBedvQtkjNAA42nHDILHHjWS018CvoeJnU=
X-Received: by 2002:a81:b60d:: with SMTP id u13mr1947392ywh.382.1581357708988;
 Mon, 10 Feb 2020 10:01:48 -0800 (PST)
MIME-Version: 1.0
From:   Muhammad Ahmad <muhammad.ahmad@seagate.com>
Date:   Mon, 10 Feb 2020 12:01:13 -0600
Message-ID: <CAPNbX4RxaZLi9F=ShVb85GZo_nMFaMhMuqhK50d5CLaarVDCeg@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Multi-actuator HDDs
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     Tim Walker <tim.t.walker@seagate.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-PolicyRoute: Outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 mlxlogscore=931 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002100134
X-Proofpoint-Spam-Policy: Default Domain Policy
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Background:
As the capacity of HDDs increases so is the need to increase
performance to efficiently utilize this increase in capacity. The
current school of thought is to use Multi-Actuators to increase
spinning disk performance. Seagate has already announced it=E2=80=99s SAS
Dual-Lun, Dual-Actuator device. [1]

Discussion Proposal:
What impacts multi-actuator HDDs has on the linux storage stack?

A discussion on the pros & cons of accessing the actuators through a
single combined LUN or multiple individual LUNs? In the single LUN
scenario, how should the device communicate it=E2=80=99s LBA to actuator
mapping? In the case of multi-lun, how should we manage commands that
affect both actuators?

For NVMe HDDs are namespaces the appropriate abstraction of the
multiple actuators?

We would like to share our work mapping LUNs/Actuators through LVM &
MD-RAID to study the performance characteristics and hope to get some
feedback from the community on this approach.

[1] https://www.seagate.com/solutions/mach-2-multi-actuator-hard-drive/
