Return-Path: <linux-fsdevel+bounces-5330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B65F080A943
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 17:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4742811CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8E4381B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GmOJR8qc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wsSabB7A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D09173F;
	Fri,  8 Dec 2023 07:02:09 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8DOEEK028731;
	Fri, 8 Dec 2023 15:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=oIejBbs5VQQa2t20WpSPvsnmr+B/JjIwJY6i/+o/dz8=;
 b=GmOJR8qcH2iQxpjOrnBTwSDBuHpzYo3pHzCuGXxdF5ioWCdNHWS2jU3alb57FKy9b1YL
 b3Jnwau5HEeSB+Yq+AdJFk1d8CPbC7oXHAz5kvrJj+dp9YGIHjyD8ae4n0CoFHbF9gJQ
 R4fLMI+VrEIoz/GUJ7Wvmmeh0NNr3I7hgQidogbq6AtFwzmt9XH8wU51NCMXT2ENgVGM
 yn+1Y7JTCPvqqqk9J8WwWjiq6fbVwUV2svLLY2k751K6lDdVHO9j3oQpn5VKJBeSfsF3
 ZjrWBQNKzpREnjdRH1/j1BjDsDhGNONBKXB8u/xdhRejprXb3bxGqpne7JZ9csd6YSbg jg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0mp5qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 15:02:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8E1k50016760;
	Fri, 8 Dec 2023 15:01:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan7qmr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 15:01:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhbuNXShzj1jWSAk+06bpzXFL3I7PbzjMhND2N4frWDJSgLHfKfwn6p2IduQk6zGJ/0YglWvHOpCEEAxXN4kOoEcvdOaWSeW3qSTfcBcA+BSPHqhQEbgH04bXxpWItZ6lUK+4xCwHTSJUGlnKPnCEqhkUDpTJ2Qjs7mOukfCJN3FWKUQlU0g1kcelFGHRiuE1Hbs8LayxeSRysVJMngA0fvLtXximgpqgDdpXtmwaZeZHpClFpnqSqau/2/sXjVSdw7xc/L8ka/AeO+DL+b+utx3RYBwDzEPvp3P/FY3QGLj9d5Kns7luBVrAjdcQfuWRckKtnJ/8yZRiwqYGGK0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIejBbs5VQQa2t20WpSPvsnmr+B/JjIwJY6i/+o/dz8=;
 b=YMA2fqqIOpt4Ywv/Fij3NUEITR9zpbRCUCgxnAGj3q81JP3U8Bbs2jDerWtj8H9vIcsblMDKLt5VPx6JCRrMVO6XxA09M5UVAL92C+Os1upSQovHILmKACn//3d36nfS3jKMWtcfvOvCGu2LWYhhFvnOIkaTKY1pBET8ktBSGgKDt0Ky0N2sDYLKw0ksUFYbBrjxshnPsHnLqAhEyW3OBCmlqPme76b2FtzDA4pw2UiSahqbkvgK+jNJzoyyHuNBB3wdThn0HU1c//XmoqyFHdUIHpmAfG9MlEKvHTungnHGsCa1SJU/Yeh1JDk0NHbyX3lDflJIL7Rzr426dggQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIejBbs5VQQa2t20WpSPvsnmr+B/JjIwJY6i/+o/dz8=;
 b=wsSabB7AM6m83fBKHeA6x+BNFX+nMMkI6dekGWT0ejskLAsAeCwUvmJvV9cE0EKktB/8pi8Jc3w6f0d9YgqO9AraUZRf+AZyOb4/1A4a1DBoGdww49glnJRXBRWmk5euZqXK3ZFWARciedSyMQ8GMz6Jg88vTl4Ti8ZtYOiEQqg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4198.namprd10.prod.outlook.com (2603:10b6:610:ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 15:01:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 15:01:57 +0000
Date: Fri, 8 Dec 2023 10:01:54 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Message-ID: <ZXMv4psmTWw4mlCd@tissot.1015granger.net>
References: <20231208033006.5546-1-neilb@suse.de>
 <20231208033006.5546-2-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208033006.5546-2-neilb@suse.de>
X-ClientProxiedBy: CH0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:610:e6::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: b177b677-18f0-48a1-646c-08dbf7fe9f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HK0q6EMmzEiXcYCoo5DVkPYu+gh79MwwhK1Yf/IOD46Gk7nX/4a2Jr0eAqj4ka6dTEhJxeTMvvrhLPsr8uF1LX6pOq+5w7OI6vQWUsrpHHwOGxRX50lKMyzm0J2gm00LPzZUMWmdGikqQI2AKCyGjxKtTVwRzkKcnEeVxm1xfKaKmvES1tm3GTMfCQjFzYhjOsZzstelEXevJuj5sdad6n1xxg7pq9cGKahEgS9wpdA4dvopj2oq+XivI9WUSuRXGtbgmY1bTPQYOaVDODUT+pZ2AQZxGVPQ3OzYryIdPjgfJKO/mUOlC9R2CyG0aES24C6iteXFAQO8srjdWd4PaQZjq7m5bu+tHAj94tI0M+EX7SPUOzyCZC6x9bfLDjTCExJc2ZCVlDfW/zK8thWskYxJjsAN7Hf9YsVSa2ls8Ie9PVjHGKP4C7f8+vIaZB8WTDAxVLT9ERy+lns8vg9p57bm4j0tn3mjgdt3/zl6m9cHEDjvFcgpVeD/XBN2QG4eOb3nUYZhB4wGr7Ch4MzLMqWfTzBspykVepvwkb65HTOuXNsGBUF/EQV+vnwSru3p
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6506007)(478600001)(44832011)(9686003)(6486002)(6512007)(38100700002)(6666004)(5660300002)(26005)(316002)(86362001)(66476007)(66946007)(54906003)(6916009)(66556008)(4326008)(8936002)(8676002)(2906002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rWSBj5KnHzyb0KNQKEjciR6MhobZYd5SokekqjJvjABjp3wNmdtPJF8N4F4t?=
 =?us-ascii?Q?55AqaERtlVphRTTcIEEsARai0lHD/OykpK4bB1lzGmh78f3loyjOpbAPFa0W?=
 =?us-ascii?Q?hMxJCfYqje31iJTpBqYk22Kziyl8R1QMVBP8VhQu6L7tly47zs7ziFy89Kk9?=
 =?us-ascii?Q?rikwy2f0yQaoGl0Z6t0eg97VFlxQWRibHQlxe6Ylt/3KP8Xz6Nrrpu93cd/I?=
 =?us-ascii?Q?iO55OImJ9cixpO6bLRmGxWlY77ANvZHIku7G1CO0VSDiqp/JHiqGS3TQr8cs?=
 =?us-ascii?Q?tvkmBWJ+w+0qdWmq9blF9iUmU0NrWRb8STG58nsXyARsBiu/L0/x34X1TgpR?=
 =?us-ascii?Q?fj/RNoHiISBtWQYkejj8ui8OHh/HD7FZimLzlkWzHjQUNTmm+6RHuoDlI7Up?=
 =?us-ascii?Q?E/AwW6Sv+832t8cXO6I+W3B3Y8ri7uGBwxPDhabDQaLq19Eo0OFgQU9B6Gkw?=
 =?us-ascii?Q?fPdXSuUjTbJT40qz6/BFARrbvNnw4u2Qwe0kQrLAUSoWoVYhAN1i37YqiXZ7?=
 =?us-ascii?Q?sz++WfHIn5bIP6vLxOPBYNthKjrJNLDXMYhCeYLGQynVYIx4p1U7kX8xsbJi?=
 =?us-ascii?Q?nSPGGX9iDwRUNKrzNW9N0Ku+q/nP0mU9iH/t3mMPfaOwrGDPUyrhPLno393a?=
 =?us-ascii?Q?ySnQIQ468BOM7NB4xv/s6M439dgvW0MzIQbjki2IvGuzgU6wdB4DWdK0eUK7?=
 =?us-ascii?Q?DF9pfxGg2nHNnQeKXH91QHKvhPJIqNU5aCYO6RqNgHfcZpB+w8uEOindlbSw?=
 =?us-ascii?Q?EEejVSfq6gn2P96N+BzoSr4qYfXLaxGESqaF/MOQJR3xt1ZauksO5R7f2LAX?=
 =?us-ascii?Q?Mn7ioKhq9WBjKV6NFWA/yS7n2vTnef0D2ami5c5nDc5Bql4yVEIIxqM7XyUC?=
 =?us-ascii?Q?dMMdTJrkdpqbY6nmGRvhm/yPajZ7CVtgVaT8qM2QdYNTGrSyQYvhp0UDQpEb?=
 =?us-ascii?Q?8MK2J3qKfZts2csueIMRS30QkaRhySx8/HsJMifUcSABHF9coHnzOJ12cA+9?=
 =?us-ascii?Q?r9Pw8GQLH1kL7Mza34hQLybGpuX0zTRd5hZbJSAUGlqP1oI2HR2TE3cDYadN?=
 =?us-ascii?Q?biifXsn2EqGUU2uco0FhR+MCYExijOSQDbiY8/nTztBvI3mh4abwSQ5zAi0S?=
 =?us-ascii?Q?J1t/Ba3YqUW4sQpK9CyME668436iwG9rCE4SIiId4E4ZlngijHeuQeXHzakr?=
 =?us-ascii?Q?60x6eGfcwWmVy2JtaWukowYhKFMrumWtgqVAoEFf+Lkl5iPBJGG6Ivzobg3e?=
 =?us-ascii?Q?Qh0jOxGVLKBI7HtCPfF6LiIW4iQUVdxpX5pH9WzGvW8226SOmUuiUutmWV2W?=
 =?us-ascii?Q?WHAqmCn8ZF7NElgh4INlHc5lY3N8RQbjZtc9mC2p7E4QI+j68nX7xqHFLq39?=
 =?us-ascii?Q?57Pr8Gzdp6jjI0eI8Ok2Io4cB6kLK/y7HGt09RjuuZTUxUHd8yZ0VyaPWnc4?=
 =?us-ascii?Q?AO56u3wjJKWZxjUnA/Q9/t59P+sUl1fYJY3KRfzz6GWDzMArvGV0z7cDNRdg?=
 =?us-ascii?Q?mRAm1MvOY7R2y3wucoUO+HwzAFDgWwmR1ajKXBqPTnQerokmwLHh6Gj7UrZX?=
 =?us-ascii?Q?+miWZcAohyQgCr94i9xd92VyW6XeFW99ROVix8mlGE6N3oL8rLUqeuTno9sv?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YiTMb6C6QPmuYoXAljnkv5WNtW9tIMwIHR5KaKzqv412P35xQpEkKstKC5x5n9/L3sE9ibVt4EDhhNoAooFI7pXCaD7Ip9Jx+OlNva/Q3w4n8oBf8/t04U8qomi6tcu0/63see7uUTe3kMnyCdPDJs1NfBuddeaHxgHW7QvZUpmllCCIbFLb60OnVcACq4x789jiojXTueyIPbj+HVFGwixhJa9gp2vMyJ4mlrccslN1LEVM4pdGsrRDFtoAfDZqI4/n1vQ4HxJiim9e9HGJPLdZtKyvdFN/L83CW0KddaP3y6oFH5wvJK8zneGQni1RUSSiUXNFIQbBiIKVVBw9FudrToPAztvSTxTG0jFtQHPXdAldKrlbMMpIs08GV3zc1c24tmMzf/NJknv3yACryReIRlcEs/l/GZRx8moEQVHDOlDZBHZWlGIA73v3umE0OJCjEX35miXi5xMH9Vc4MWMQOPfP5j2uQ0lRbss3290q99QeFCgciTozNQXiYJvdKISAXaU2SG6zeAnw9v+FY8n91CjvyzMEXI6fcJEaBj6/PhCpBO2YtyF2hVXYw+MVTprrigQz4uKdCB8oJlkTCssE1W+XCvSk2vHGOC7x6z0E4l6Yb79j5m0zJ+kdgvgc1904tpMocb/iU+iQkgCLVL1wp4+sWeTAO9KzQ49tPvjXmTj0rRCU0dgjXYwDsLAs9eg8D8yUqmOmfMDrQFRfc/9ej5Ef+2iY6sOZtIRGXMSNWydt77qHXvbwBjM+uSk1Pv4QgFDd0qRyIVt2u7BwF/Fdv3Op4J4OJn428LXaxjVEx69KSKylqSPH2lwewKL7TO9VT9Abs1o9Nl25W5sG3g8h3D36sTpn669sqKirvsoPjvho6rEXdcAz3fAZZnExJdDGlF9UY3EiL/I1xExjIjFgGNPw+zYBWYABj+qrDLM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b177b677-18f0-48a1-646c-08dbf7fe9f6a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 15:01:57.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vq0UUkQrjVxHg8+xP/FPRBYOOs4YRUzPXTgbHa6/pXCRHS0AG1fCRKXkkB7AKd6BOL8B1bbuBNaHRQ7ACzomiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4198
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_09,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080123
X-Proofpoint-GUID: 4Ze4Tc7ugIgoRk-15uWd_CNmx12vgN3j
X-Proofpoint-ORIG-GUID: 4Ze4Tc7ugIgoRk-15uWd_CNmx12vgN3j

On Fri, Dec 08, 2023 at 02:27:26PM +1100, NeilBrown wrote:
> Calling fput() directly or though filp_close() from a kernel thread like
> nfsd causes the final __fput() (if necessary) to be called from a
> workqueue.  This means that nfsd is not forced to wait for any work to
> complete.  If the ->release of ->destroy_inode function is slow for any
> reason, this can result in nfsd closing files more quickly than the
> workqueue can complete the close and the queue of pending closes can
> grow without bounces (30 million has been seen at one customer site,
> though this was in part due to a slowness in xfs which has since been
> fixed).
> 
> nfsd does not need this.

That is technically true, but IIUC, there is only one case where a
synchronous close matters for the backlog problem, and that's when
nfsd_file_free() is called from nfsd_file_put(). AFAICT all other
call sites (except rename) are error paths, so there aren't negative
consequences for the lack of synchronous wait there...

Consider at least breaking this patch into pieces so that there is
one call site changed per patch:

 - If a performance regression occurs, a bisect can point out the
   specific call site replacement that triggered it

 - There is an opportunity to provide rationale for each call site,
   because it seems to me there are two or three distinct
   motivations across this patch, not all of which apply to each
   replacement. More specific (perhaps naive) questions below.

 - It's more surgical to drop one or two of these smaller patches
   if we find a problem or that the particular change is unneeded.

Also, it would be convenient if this patch (series) introduced an
nfsd_close() that then called __fput_sync():

 - The kdoc for that function could explain why __fput_sync() is
   preferred and safe for nfsd

 - When troubleshooting, function boundary tracing could use this
   utility function to easily filter (sometimes costly) calls to
   __fput_sync() from nfsd and ignore other calls to __fput_sync()

But if it turns out only one or two fput() call sites need to be 
replaced, an nfsd_close() utility doesn't make sense.


I'm trying to think of a benchmark workload that I can use to
exercise this patch series. We've used fstests generic/531 in the
past for similar issues. Any others to consider?


> This quite appropriate and safe for nfsd to do
> its own close work.  There is now reason that close should ever wait for
> nfsd, so no deadlock can occur.
> 
> So change all fput() calls to __fput_sync(), and convert filp_close() to
> the sequence get_file();filp_close();__fput_sync().
> 
> This ensure that no fput work is queued to the workqueue.
> 
> Note that this removes the only in-module use of flush_fput_queue().
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/filecache.c   |  3 ++-
>  fs/nfsd/lockd.c       |  2 +-
>  fs/nfsd/nfs4proc.c    |  4 ++--
>  fs/nfsd/nfs4recover.c |  2 +-
>  fs/nfsd/vfs.c         | 12 ++++++------
>  5 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ef063f93fde9..e9734c7451b5 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -283,7 +283,9 @@ nfsd_file_free(struct nfsd_file *nf)
>  		nfsd_file_mark_put(nf->nf_mark);
>  	if (nf->nf_file) {
>  		nfsd_file_check_write_error(nf);
> +		get_file(nf->nf_file);
>  		filp_close(nf->nf_file, NULL);
> +		__fput_sync(nf->nf_file);
>  	}

This effectively reverts 4c475eee0237 ("nfsd: don't fsync nfsd_files
on last close")... Won't this cause a regression? Jeff?

And this is really the only place where a flushing close can
produce back pressure on clients, isn't it?

>  
>  	/*
> @@ -631,7 +633,6 @@ nfsd_file_close_inode_sync(struct inode *inode)
>  		list_del_init(&nf->nf_lru);
>  		nfsd_file_free(nf);
>  	}
> -	flush_delayed_fput();
>  }
>  
>  /**
> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> index 46a7f9b813e5..f9d1059096a4 100644
> --- a/fs/nfsd/lockd.c
> +++ b/fs/nfsd/lockd.c
> @@ -60,7 +60,7 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
>  static void
>  nlm_fclose(struct file *filp)
>  {
> -	fput(filp);
> +	__fput_sync(filp);
>  }

Will lock file descriptors have dirty data? This function is called
from nlm_traverse_files(), which is looping over all files in a
table, and it's called while a global mutex is held. Any data
showing this won't have a scalability impact?


>  static const struct nlmsvc_binding nfsd_nlm_ops = {
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 6f2d4aa4970d..20d60823d530 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -629,7 +629,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		nn->somebody_reclaimed = true;
>  out:
>  	if (open->op_filp) {
> -		fput(open->op_filp);
> +		__fput_sync(open->op_filp);
>  		open->op_filp = NULL;
>  	}

Isn't this just discarding a file descriptor that wasn't needed?
What's the need for a flushing close here?


>  	if (resfh && resfh != &cstate->current_fh) {
> @@ -1546,7 +1546,7 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *nsui, struct file *filp,
>  	long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>  
>  	nfs42_ssc_close(filp);
> -	fput(filp);
> +	__fput_sync(filp);
>  
>  	spin_lock(&nn->nfsd_ssc_lock);
>  	list_del(&nsui->nsui_list);
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 3509e73abe1f..f8f0112fd9f5 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -561,7 +561,7 @@ nfsd4_shutdown_recdir(struct net *net)
>  
>  	if (!nn->rec_file)
>  		return;
> -	fput(nn->rec_file);
> +	__fput_sync(nn->rec_file);
>  	nn->rec_file = NULL;
>  }

What's the justification for a flushing close in this path?


>  
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index fbbea7498f02..15a811229211 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -879,7 +879,7 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  
>  	host_err = ima_file_check(file, may_flags);
>  	if (host_err) {
> -		fput(file);
> +		__fput_sync(file);
>  		goto out;
>  	}

AFAICT __nfsd_open is used only for creating a file descriptor for
either an NLM request or for handling a readdir. In fact, I'm not
even sure why there is an ima_file_check() call site here. IMO
there doesn't need to be a flushing close in this error flow.


> @@ -1884,10 +1884,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	fh_drop_write(ffhp);
>  
>  	/*
> -	 * If the target dentry has cached open files, then we need to try to
> -	 * close them prior to doing the rename. Flushing delayed fput
> -	 * shouldn't be done with locks held however, so we delay it until this
> -	 * point and then reattempt the whole shebang.
> +	 * If the target dentry has cached open files, then we need to
> +	 * try to close them prior to doing the rename.  Final fput
> +	 * shouldn't be done with locks held however, so we delay it
> +	 * until this point and then reattempt the whole shebang.
>  	 */
>  	if (close_cached) {
>  		close_cached = false;
> @@ -2141,7 +2141,7 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t *offsetp,
>  	if (err == nfserr_eof || err == nfserr_toosmall)
>  		err = nfs_ok; /* can still be found in ->err */
>  out_close:
> -	fput(file);
> +	__fput_sync(file);

Do we expect a directory file descriptor to need a flushing close?


>  out:
>  	return err;
>  }
> -- 
> 2.43.0
> 
> 

-- 
Chuck Lever

