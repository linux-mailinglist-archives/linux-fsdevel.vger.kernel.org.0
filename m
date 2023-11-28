Return-Path: <linux-fsdevel+bounces-4035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28217FBC7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 15:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F6A282A77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 14:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BEF5ABA2;
	Tue, 28 Nov 2023 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="WDGVXEqL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAEAB5;
	Tue, 28 Nov 2023 06:14:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTsSsdcNuX8Oa6mJsUXpkEMHfiHF5s5zMelDLB3mFOYkF7pyixM57DAh8H1Y7mekPlc/eFEmmf/sDZyb+lZFLbUUXHzCODUaoUHKDpP1m7ELad+MuS3+t8GUIuk/rvUMd8wjr1izwSfNH5xGDMa49qmYMO6gMeSFHvvjrLNLZukAHH0L0sVqHsywoCcIjtKolJdDQkp9KmaFDdhPqSEUPqDqvsHAEWZgZygod3U1NDG0j9YVeCTVfeQ2cDFF65v8ZaCnyYAbLZbW8pryZbVrXnYOXyjdMTh7lVaILCgA5PNGJbpR9fU5Dn7qBVTrP8oeRcjwYXzD5Jz4LbdAy38O+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd5ND/9oXJ31iUjetN87bkrJzmWvr9H0e7/w272huYQ=;
 b=lko3sJQOLiQ58J/bri7GMgeTmNShjXbict2TZbK9WeZb3HBtdB350qDRrD9NDrFflQ8bxsrVUEF9RoOgdq7MDBYQPdSCx5UUlHN3vd2IUiwvgkk5JdB/6CpjCWaqeJIBeSxnzzkKnTlyZuocosBXdyRPG9NHl9tVU6P7SM074JhpYl3OtCm2dbTkJT16/Im9QC4CTdcWwmRqsHp4Xm+72JaydNFV2vA0T5jFklNP6wLHYqrLZT4HJMouvtjLTcP9Umuf7Rvqpe6uUXFhcyYl1YvRO5INJlP8mQ47vTVDE6wnhUVnLiEzidDv7SP3z7DhWZvZkCDLrWmx3YYJ9PPC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd5ND/9oXJ31iUjetN87bkrJzmWvr9H0e7/w272huYQ=;
 b=WDGVXEqL0I2xXZbdDrwPUG58eGSSP429Y31qQ871YDhjl5E2gaLmWztxJbmO8lRZvJkb69KdeZi6zSroVvOvKSgOfZPfe+tLJmehZbP4t8h4B1CZ0Zdd5NhpWCeXzo9kwsqhEbGH+rP9PF3Yf95ljHgB+idadC1rIRbdCR3Zi4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH2PR17MB3816.namprd17.prod.outlook.com (2603:10b6:610:83::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:14:51 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:14:51 +0000
Date: Tue, 28 Nov 2023 09:14:46 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	arnd@arndb.de, tglx@linutronix.de, luto@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, tj@kernel.org, ying.huang@intel.com
Subject: Re: [RFC PATCH 05/11] mm/mempolicy: modify set_mempolicy_home_node
 to take a task argument
Message-ID: <ZWX11sUJQ8gQlZU1@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
 <20231122211200.31620-6-gregory.price@memverge.com>
 <ZWX0KkaUGJoUdmQS@tiehlicka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWX0KkaUGJoUdmQS@tiehlicka>
X-ClientProxiedBy: PH0PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:510:e::27) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH2PR17MB3816:EE_
X-MS-Office365-Filtering-Correlation-Id: 73612d44-d05f-4c72-46ca-08dbf01c62d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h728J2yhuXBlrVyEUs6WRKPQzA0qQCO9tZ7ABpqa2ruw7nsPKd5D6fkDVabTWU1vaJkp02EtX+1Qh0wxrwSmgt88jiBCpOW1sg/8q7ucP63aIVoP2EU6XMv/E334YOBthlpysJP3t3sFt6yiylKvXDwe08fBMpdtgFPG26gwPcdKqT0+/w1agqyuC/UhPcVMTd/NkXcJYPnbBu726ZGles5vVf+j595OnEsMDx6niGjIouN7rbN31fiiWMoEElfWYhSo5hSvbhs4oMNiNu45HWEMH9xIz90tt57TuU8RBHutjwjcgsaJYpIvSgzsjwcYmaKd+AxY5qauLWRu50TCVKl/SNZTLqlnH/6JlKL4AFYTGCOLbmlyTnTaAIrx9FC0D++OG/DDOQE1izgo8Mb+3VwFprtnPiksNgwcutcK+5L1LLygpvE8iaf+XpOoSSRNkRKNfnQZYVBoAhakFE4t3z0JaOFke3/GkzE4KbohYgH3KC/5RrdzlS/SHW4ZQhwimYhU1nJ/uu2Vy2DR5zC+F/530CGE6hy8qqMVc/runeprtkg+MJvNdXbi4IEG1qzk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(396003)(376002)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(2616005)(6666004)(86362001)(4326008)(8936002)(8676002)(5660300002)(6486002)(44832011)(478600001)(316002)(66556008)(6916009)(66476007)(66946007)(7416002)(38100700002)(83380400001)(6506007)(6512007)(41300700001)(4744005)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mOKuM8gKsPMHnyO9RW3+aFy+7PEoNuZRNrsxYpS6bNlgmP1osdv3XswyenUY?=
 =?us-ascii?Q?Ev28ZMheHO+rRb7wU4+wGLGMVyYBloRtUE9exUSYkg5X6i2VpNkFhnTaWH0k?=
 =?us-ascii?Q?JXjwNmPLX8qyvT1P70FzUngFozv8JJ9q2k7jsQOs6LjZvant59CIMUrR13ym?=
 =?us-ascii?Q?o5H8dOvpSRlmGcpoKUsH5ztOEWrRIoiJdGEIFatcqDpMkEZKNBUw742uufU4?=
 =?us-ascii?Q?9ptbLm6m+/7fIldjq4AF8yHeH/Crg9kJPFNMuvUqIAS9hl87wY4rr6Immw1Z?=
 =?us-ascii?Q?vBhofGgUl8ukwnxt2BO9jEjURnge77LqQyKnDgqbQ/VtfUWbx88q+rbUj/QF?=
 =?us-ascii?Q?k3nBVsaNPGoGlCzYXJOg/si8SZaJRqaht7EttletknIy/oKbWZTgTCfzrw5F?=
 =?us-ascii?Q?matzXDg/7D9GYGRoWERVd/rZGpgscHMQ0pqqGn9YvC3efni39FBgHQLr1PVM?=
 =?us-ascii?Q?1rjqy914DndMML/fmuV6dWojUe0j0KPZ/PX2rtYeCMTWq+Cfbr05lPTkJQfk?=
 =?us-ascii?Q?3LAizQjj4G8o1xsE348eum2Whzs9ootR7Bg4l6+U4WNHn6m17K6wP44xj6ZD?=
 =?us-ascii?Q?XpX1gWo4HbflcHC4HzkYYlHHA69IaCOFMGbbOtC5Y0qZv27A3B+cs8jwi+Td?=
 =?us-ascii?Q?1r9+kHFSgstdhg9LQWFLa5D0Lv+/4WrullmaV1pCa4eNAh3aniAs/z894pyP?=
 =?us-ascii?Q?nCIy3MKL05iQlKRRcs6xzgfItB5A8gqLUjE1YyUyVxz8keBS9vXh7TUcQ3sQ?=
 =?us-ascii?Q?pBZua898MDWl/fC4YaNXtf7SKmQbwEAWO8YKdnb29P4Mba3eWW0bK8rfDYlg?=
 =?us-ascii?Q?p27kWNNbed4Kd6iCKZgU/OoyaLNP+7zuTVQ5bw94j3lCIXfiWHz1tfld0bz+?=
 =?us-ascii?Q?LWYR24pzYkotjmWgyZ4N/jyszuBKw25+ycYOGMys7Epto6IBA/IGZlFDoO+N?=
 =?us-ascii?Q?gmbScKylSCa/n7neMUHmVU5SZmpo8iUmh7Ib6ezb/iz12vMiOP7hEXEX/97d?=
 =?us-ascii?Q?tWGyxQl+NTri0+ydovKgjUzeQJCr+1tXL8WU9AMC6tapnWjlhSQeqLWw/s3J?=
 =?us-ascii?Q?jxTgH8HUGp+bNKFJ3xtHscLQDlprgJLWiO9/9b1yR8VsX3FZGkQGJbXcnl+o?=
 =?us-ascii?Q?FgjuDvjoBQT3VqmE4ykhvRKDUlOJeUEOyAnCtAJ2HIBKfr3AdmMOK2kNzb/W?=
 =?us-ascii?Q?ldZj/SVUyB9zE9c1VKRrPgucCxuLV9OgEQS+gQz+H69MADyBawcjlJidkaQi?=
 =?us-ascii?Q?V3sSInXqIMKAmd1En27Qb5+JQjLS+Ee2uKP7JuKiyUSI//M5wFAlBoY/WRXd?=
 =?us-ascii?Q?NMD2xYjc9d3kuP9qfLtwGXIEPTaUVqOfAmn61Qy43ujM4VAv6aZBz4pqiH1u?=
 =?us-ascii?Q?egc5jcYlRBsBeyzqORF3/oWexe/2i/r97ghHOpXXrOeCs/24xxJ/+twOmjGq?=
 =?us-ascii?Q?pQP7eOc+aM1nf5pakITYLEeV8JFNiPFToR6SWnHjUwJyHPqWS2t6+fnY3mXA?=
 =?us-ascii?Q?KLDe6Gi2Pn8DtV+ORXDfd5fNrFOfS4wDNRk7Of+PPDBAPZQQgZDln7mSsSCp?=
 =?us-ascii?Q?BO8z8IjnfMvuBxDis690c7eoPuIKaxXFEL58KvDui8KcYuCbCIBnoBKVhFz4?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73612d44-d05f-4c72-46ca-08dbf01c62d0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:14:51.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3Z+i6+BUjBp2E4hY9UzPRzSaXs/7xWju89SU/LJesboruPylNNqoBm4tEQCcxt//h67Gzi03yKC5RTdMF0HYfMPbIKhmrZc9i6OssonvFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR17MB3816

On Tue, Nov 28, 2023 at 03:07:38PM +0100, Michal Hocko wrote:
> On Wed 22-11-23 16:11:54, Gregory Price wrote:
> [...]
> > +
> > +	if (!mm)
> > +		return -ENODEV;
> 
> Is this an expected error? No mm means task dying and mm has been
> already released. Should we simply return ESRCH wouldbe a better error
> code IMO. This should never happen for the current task so it sould be
> safe to add.

Hm, good point, and in fact i should make sure that the new pidfd code
is not susceptible to this.

This particular set of lines is not present in the new RFC (not out yet)
but the access to the remote task mm is more controlled via mm_access,
so I would presume that mm_access either returns error, I will make sure
it cannot return null and check for this.

> 
> -- 
> Michal Hocko
> SUSE Labs

