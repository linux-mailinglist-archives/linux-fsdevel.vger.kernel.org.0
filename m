Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D05182A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 01:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfEHXV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 19:21:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35986 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727763AbfEHXV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 19:21:27 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x48NIRsb026484;
        Wed, 8 May 2019 16:20:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lCdKIPHMGvGvKmpk8HbdROgwQl29v5EI3TaR7mBLsA0=;
 b=Pew+PYZM1QGT2MtjUHc5cGi8l27SXBbToaK7F9TuFPp3oTTYU+whHtRiRc3QZAO5Zuu1
 O+MxB7AZEYfkVoTz21gowViQXBz1TniDPynF8clJOnKu22xUcpufxvXwEI1iwlx9OTuY
 EKpgc24XYoU+S1doILWUQMg6jkQ4SFtmL9Q= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2sc7t2r5db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 08 May 2019 16:20:55 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 8 May 2019 16:20:54 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 8 May 2019 16:20:53 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 8 May 2019 16:20:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCdKIPHMGvGvKmpk8HbdROgwQl29v5EI3TaR7mBLsA0=;
 b=MV69l51gbUsBTwbnHJhapq3cSvmtIF6OxMJgTP04A32LqgR4dYeyPH63cZRVrC3GfPJ5P8F/P94ub8sNEEN6CcRQV9xTwmZztlRocVVyOzm3OLkwYjA1daGex7FkEcXwwuqElHkpL3p6Uu049K1vL8/3Gp5MkTrVbw2PHJ3oKTA=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2678.namprd15.prod.outlook.com (20.179.156.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Wed, 8 May 2019 23:20:51 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ddd2:172e:d688:b5b7]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ddd2:172e:d688:b5b7%3]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 23:20:51 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] memcg, fsnotify: no oom-kill for remote memcg charging
Thread-Topic: [PATCH v2] memcg, fsnotify: no oom-kill for remote memcg
 charging
Thread-Index: AQHVAokQTI6+FEdd6UGTORMvAHxc7KZh5EEA
Date:   Wed, 8 May 2019 23:20:51 +0000
Message-ID: <20190508232042.GA1104@tower.DHCP.thefacebook.com>
References: <20190504145242.258875-1-shakeelb@google.com>
In-Reply-To: <20190504145242.258875-1-shakeelb@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0035.namprd08.prod.outlook.com
 (2603:10b6:301:5f::48) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:524d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf008100-e7c3-4e95-aded-08d6d40bcf73
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2678;
x-ms-traffictypediagnostic: BYAPR15MB2678:
x-microsoft-antispam-prvs: <BYAPR15MB2678AB6FB8BA07664B988789BE320@BYAPR15MB2678.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(54534003)(6916009)(1076003)(86362001)(2906002)(102836004)(7736002)(6506007)(386003)(71190400001)(33656002)(71200400001)(25786009)(6246003)(305945005)(446003)(14454004)(4326008)(7416002)(68736007)(46003)(73956011)(478600001)(6116002)(5660300002)(66946007)(186003)(66446008)(64756008)(66556008)(66476007)(14444005)(256004)(53936002)(8936002)(6486002)(99286004)(52116002)(229853002)(11346002)(76176011)(6436002)(316002)(486006)(54906003)(8676002)(81166006)(81156014)(9686003)(6512007)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2678;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M9ViFNyD/FCUCLUJj4EkV9tPxnfSYa1qKvRE+Dut1F1h5GU8e2828C3QhQncfW4qAWfT8O8S013bCbISnnrTQaj73Z/2z8mj0OPfbOP7pL7QZnO9/+JFq/Qss6tCl8oWbM87NSOrWO4gCfPbzMavhcAKIY/fXvY8z6ckJ+G+ys/1c9tq/6KVpwqhHgOotzHwJRAHnhnInB7drqHvB9xcS76uWuiNWe9HOgL4JXl4FS7nyvsPVzmuF24FXH2HMlSkZSGylnyU+EnDx4fGajZ16euc0btpq68mGpe+wVAzAFGT+2bDJ4PuncwXvR36kInToCsZQ8+l1pdHAS+FFu3qCxkjR3SvkGLRr48eQ6uMFQUbLY/A9TFYZP92vMLbVRW2BpXzndx4YCkEf6FwHOohc4+8NXTeI4Bk4gh/Jm+WVTU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FAA360BA6EA9A646B5F14EE9A945F468@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bf008100-e7c3-4e95-aded-08d6d40bcf73
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 23:20:51.3370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2678
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 04, 2019 at 07:52:42AM -0700, Shakeel Butt wrote:
> The commit d46eb14b735b ("fs: fsnotify: account fsnotify metadata to
> kmemcg") added remote memcg charging for fanotify and inotify event
> objects. The aim was to charge the memory to the listener who is
> interested in the events but without triggering the OOM killer.
> Otherwise there would be security concerns for the listener. At the
> time, oom-kill trigger was not in the charging path. A parallel work
> added the oom-kill back to charging path i.e. commit 29ef680ae7c2
> ("memcg, oom: move out_of_memory back to the charge path"). So to not
> trigger oom-killer in the remote memcg, explicitly add
> __GFP_RETRY_MAYFAIL to the fanotigy and inotify event allocations.
>=20
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
> Changelog since v1:
> - Fixed usage of __GFP_RETRY_MAYFAIL flag.
>=20
>  fs/notify/fanotify/fanotify.c        | 5 ++++-
>  fs/notify/inotify/inotify_fsnotify.c | 7 +++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)

Hi Shakeel,

the patch looks good to me!

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
