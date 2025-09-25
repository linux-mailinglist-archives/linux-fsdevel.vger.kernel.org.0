Return-Path: <linux-fsdevel+bounces-62820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDC4BA1EBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 01:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3252560651
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 23:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEBA2ECD20;
	Thu, 25 Sep 2025 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ug+7LUIF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178712EA754;
	Thu, 25 Sep 2025 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841467; cv=fail; b=Euc6OUzdojYJ9A7vDtsYlJ1hRwzrNADemlkC6RZuSmnPTT92v2XoPTofXSH+9puzcZujKR9qT/RGIY0QSbzu516Y/Alebb6c+wOeBAhhcYoOg0J6ValZxlEx+Eg9J7KMKzR/jQeSUUKNbVWdldxaf9l2rMwZXGojiBpWlWjEFOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841467; c=relaxed/simple;
	bh=nczZQK++5SZ52JS12iT0cwdEH9IYVSBxLlVQDfqEe/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F5AAOSJ+wVeZfXRnbhhC5xwfaiYMyAAoBgr8lc8T2WeiRydXT9UUsQ9ETG6BQ9bS5fhPcVpxd4L56Uw77J4Ka/S72nNz+GI6/3MyDUUfEOGGCmxb8zwCbYGYhO33VYRiepEpA9u28vB+IyNhXFM4rBm3btUE1SnDF+cr+N30pVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ug+7LUIF; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATInZTBd69vEM0PXEjlLTNFa5SaIAt3eyjf1VeG7LxcvoiAVe2YWz/g6rwQe+KMnzdeGAmlk0BTOygj6O0D11G7DBkXF2QZFIEIxsK4fsZY+ly8CMIawatymXmAp37U2+0CDy62aEDsq6DAUT9BJoNsjX4vtzJHw7jCpcO4iAdQ1TCrXlYmAODPs+M9vkteGlxys3IyJYyi8gnFnAM96n9WXdPZiXZQqsv0DWoUopJjAAYTelKLwb/BCFej4YS1xDR6V083Uk/yVC+f5m8ZVRCuJjIwB5s/Xv55IB+8bRaGDvKYGvI3VfNQYUMkK4e9HWScENgrdO4hCLsQq54oRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKao8HJwvpIeQoGVjUsM1jhX6PHn5tobkbs0HBICdCU=;
 b=Z4ONMJGVuRUjxyzIXDXyUcMhEzsiYovGD8GUUJew9ByVzm/2ZHLsbOOr4SYrSlE54ngSpF1OXxL4zMCeSjcZPmO79XDbK9qRfgsWupdmomdnqmhxFe/kL9cuwvGxvhX6uR5DqB/b7gjbtOA/pnX0Wjxmk98pGEM68q/9+FHJro5ZzV75F4IAa4FK13MyiNo4Q3irllw8espJgdLRgvP3BtCN2oPsiuKAgz98grr5EJQmtvNXSVmQYtt0Qz6VgcX46rrtMW23QCVc9dMsBga0ZLFl1G/Rc5NDBkZj0URfmKcoEfi+3CTEMKVZx76AlANzM3OvjuRmqAfX/wQmd4eGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKao8HJwvpIeQoGVjUsM1jhX6PHn5tobkbs0HBICdCU=;
 b=Ug+7LUIFVn4m5+KqBadgNsp0wel5rzQeiaLy1v5aNHe7r9DIVQHd+aNwZO1zxV/H5UDzmTTdauo0m+29synuURJSwTFGX0iu32n2kCm88PgG+lpwaYwKqwuvb3TgaoBHAhdQiu2Ct4w1iolR0yYHI3RpFERHZvgg7ueBynBfFGiqkycvvTpFSOyrZnAf9rzmxE2TzQqoblGtzA/3V9MOmnlqMSBMs19uwDSkpkZsebeyjBCbaAhI3HP9XPbaQmck8LTEa/9FDQASy8VrnXONXadDBbrw36K51KaT3NfZKRsV4yJh8ZViZgA9OaBif/5J9MQ7A5jr4wjVQw2X4D3fYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9; Thu, 25 Sep 2025 23:04:21 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::f5f:6beb:c64a:e1ff]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::f5f:6beb:c64a:e1ff%5]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 23:04:21 +0000
Date: Thu, 25 Sep 2025 20:04:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Shivank Garg <shivankg@amd.com>, willy@infradead.org,
	akpm@linux-foundation.org, david@redhat.com, pbonzini@redhat.com,
	shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org,
	viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org,
	chao@kernel.org, jaegeuk@kernel.org, clm@fb.com,
	josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	lihongbo22@huawei.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	tabba@google.com, ackerleytng@google.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
	bfoster@redhat.com, vannapurve@google.com, chao.gao@intel.com,
	bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com,
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz,
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com,
	rientjes@google.com, roypat@amazon.co.uk, chao.p.peng@intel.com,
	amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com,
	ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com,
	pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com,
	suzuki.poulose@arm.com, quic_eberman@quicinc.com,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH kvm-next V11 7/7] KVM: guest_memfd: selftests: Add tests
 for mmap and NUMA policy support
Message-ID: <20250925230420.GC2617119@nvidia.com>
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-10-shivankg@amd.com>
 <aNW1l-Wdk6wrigM8@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNW1l-Wdk6wrigM8@google.com>
X-ClientProxiedBy: YT4PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::13) To DM4PR12MB5769.namprd12.prod.outlook.com
 (2603:10b6:8:60::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5769:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 3836b33a-33fd-4724-390d-08ddfc87dd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0uKy48xu78VOYFaHJVK16BBu3/XQ41txItbK5Vcx9cXM4GOG18djJBn/r8M5?=
 =?us-ascii?Q?EVB8YbxWbXoSw4d9gxht3/Dc158117KukqeeZIJgwyjQVISz7eHcZB0BpUyz?=
 =?us-ascii?Q?Bns0Wtf9leAk//k3/vmpdP3FxI7CSte/0gFxR4DjrH10siVJrFU6OacSmIPl?=
 =?us-ascii?Q?whxG2aKxZLchp+mP2tBLzao0xkSKvpTamYMfJPXzKFkh2StQ2ZQBDVF2mGmg?=
 =?us-ascii?Q?d9Y0ZDoLpu0E0LCEonwymX4PMlUWmSN/ARdn/cRbxWO4k6sJsBQ5RF9coL40?=
 =?us-ascii?Q?lzr3cX9k+IDD+xlZ/JinhmkAveQTulsHBhZ7EYlwRdOyJxoHrBPstNF7XA0Z?=
 =?us-ascii?Q?u3/7GMqqvUiacKxg2T/TftGvQHGPRAqkVH14tBrMvJnTtqcg1uNMq14CC8Ew?=
 =?us-ascii?Q?R3zDf8aTku/pk4G1a3sLhQzjf0+C3As3Wo569vG7bSy25Dwjthq/6YEuCpWu?=
 =?us-ascii?Q?jnxwdGWp+FqFyiqChhVrT5KQ3yKa4NuVr9P3yUYghEcBmp39AsXcXLCjRuhs?=
 =?us-ascii?Q?M/TVOj6+3DahXURcigAjbqRyqccB4VOL6oc/Ngt2pFSuW2z3LCMjZ4+VwCoh?=
 =?us-ascii?Q?hVK4U33aX6pQsSOaagB1s9ujQ6Ptd8tg13NJpTuVemYUBD8mHnefd5PXiWXt?=
 =?us-ascii?Q?zpmZipK+BM7zogc5oEPMqGG6O1ioCu+UIneUKiuDeE5b+60zEFuXrGdshIcT?=
 =?us-ascii?Q?pxphArmKNElLYL23ReIlR+v36Re/DCkuwsLayh3kJg8WTNmm8WVgzShUcS9g?=
 =?us-ascii?Q?uEpbi36IstAaXhnxqeMHJMFUx0I3EgqDvUNRpxV6r+EzAJw5f75ZQTXFlV+C?=
 =?us-ascii?Q?vwEyg6Mcvl64sgn0RIfvVRbDePH2Haw0w0PnnpCIuSWsdF4b+MxAaIrMeNrS?=
 =?us-ascii?Q?gp/gzTuHBHJHL+ZhwFB6hyh+T7q4rVP0SmxFGO2NM1pqjGrZDq3qYdeORfUX?=
 =?us-ascii?Q?b3O7JB3l4k4DJ2tG1V6NupI1UaclsLBPOujZk57ss2rkN3JXUzg4jyhqMfVW?=
 =?us-ascii?Q?xArmf+vRocogZdeGJbQabdk6fPgd0wdLWw+4SoOzB8PNVrqgjP9FxkOsnnRo?=
 =?us-ascii?Q?9ObEiQU8PDfDiib2CeaHI29/6RBctPYBbV4wRhPx3xv0+ikJuu6S9nda4Kb/?=
 =?us-ascii?Q?9GqRn22v4wNzsdSCGpeQIeC9zzveaKoniDRTxw9r/tiArIb6E2kKXKXIN22n?=
 =?us-ascii?Q?/CJ3ePVnaNXjEoe/T1RPFA9fjcYM+PMmmysP+1Guatq0PITCDNdrLGGNjtZu?=
 =?us-ascii?Q?S9RUJesvp9SDnWeFqjqqf2JnwJ7Juk7b9KCT0d6bKTd+8m4jex+l7nxe0EAH?=
 =?us-ascii?Q?nwulNazbDWWzP8zlPnvh3q5IgX5JSU5TWefHO1zB+JTufjsXoG5NsTjdyI1Y?=
 =?us-ascii?Q?i/RcoLjRdPHMqbEyPRmxa8koigoSNr5gPuyjhH8/wO34M/Sh8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMVJnQhszAwt8cquuiP8OFIq1jZNn7n5sFCFz9chGpkP41QUdQb26qsxioLy?=
 =?us-ascii?Q?1PeOa4yqslrcCxQ4Tar7ovA/gXHRin5qLMCCMD3mVTQyLKigs1RQ80C82cXP?=
 =?us-ascii?Q?yq16U/26huUFSoxh2EkOghN+ka7y1GsKWHLqx3p9V3CP7GJjJ1LX0B5zlLx7?=
 =?us-ascii?Q?VuZD4/th/VsaBoeX7GIoROZB4jXp4US2eL0wpUrbpvH7gJW27l0SNH6lZ3Q9?=
 =?us-ascii?Q?WdrYfJwD8JXcfsF0vHjS31TApGsFpTH76h96+1YPB+dDruV1dUwN8hIWXnSd?=
 =?us-ascii?Q?Tuqw7uZ7LaDkMyKITv2CkSxcssy/BAHrp/Qt4Fw5t8vRZYtNd/136ge+Sw0Z?=
 =?us-ascii?Q?qREZJzHTzneJqA0FuuTNSEkFVF22w0d4+Se1162nZvARoJBuGJsnIbZreF2l?=
 =?us-ascii?Q?GiRXsQxxSUSy15mOSnZWJXe7oIPRQv45Z5Fpygc04YbaudGhhThYddVdYX6t?=
 =?us-ascii?Q?Vsib8uGu+o4mQ4VYzNskhFu6CvJiQ2mPXInoOeDIbQRX6tgvrzyqHsKp6OH0?=
 =?us-ascii?Q?ub2qer0xxnNywbbxen3PvmLIaizU9aoubxN1vxozPhksRTljuR9JVEB/BYjJ?=
 =?us-ascii?Q?Jtups2/vSR+WtSv6jUcxT6gJ7JMEm8srd3KeLoFuFfSLjS6WSRnjQF2UIMSV?=
 =?us-ascii?Q?RQ+cUX+pX6/m+eayoQVILudCmR95Nsft77DNvV3uzcLC5pxgHImCTRmc7SzB?=
 =?us-ascii?Q?Xr2mbK6uJtNmMNtajCD3BRMTQtkwGfoS1qBPSDgsMyFPO+oDyyO7bpzJWIkM?=
 =?us-ascii?Q?A1tgK4CJVr8tsaJ6pOmtCDxzP/VNKQu6ZeGNFJidt3QKfGFLbun9FhDo5vo7?=
 =?us-ascii?Q?F/dpTFdR991QYe5CEM5KDdMTjrW9zI96tIzkg9Y2hOegKl1yRMkjGXhQ+N29?=
 =?us-ascii?Q?K0iTvEv39PO3q3+n+whtwkmAa+3nugASXjANsH2Vxrwf+1LNUFPNVclDCl5h?=
 =?us-ascii?Q?tgE39PPFrURWePg5hLS+pl4pK7Bxz/pQB7Rkt01ObnzxsdbaJBDJN5ErgVeL?=
 =?us-ascii?Q?jFymnggZ7nEoJ/zf+XE1slj0wDqSivNlZAU1XGPsfTw49+7UbfK5yyJCXrrk?=
 =?us-ascii?Q?BgljF7O9Xr5a5BkuClfEl+egmNO0rqtjeamwdCjzIzp2uLLqRmhUnviufWuu?=
 =?us-ascii?Q?Nodvx66rCQxEt+r02HQPF9RToLrvOvQqhAQpQHpRJpbHcz9Y23ZuRyhbvFod?=
 =?us-ascii?Q?xIhPkxmMSb1bO7OqZ5QvdlAaD/R2ZL+NGMvBwCFv9jQyv8ZvfQsJMshbx/mi?=
 =?us-ascii?Q?YoGeOV88lX+ugf7Ha7QiNTS2+/9vsFK7dng1hCYRaTHH7msb95+4Q/BGSpqM?=
 =?us-ascii?Q?vPu9eoThHL55oDkufxBuIm5haxKfDkuEGSyf55lAOZ5q0g0aSfl4LgPssq1G?=
 =?us-ascii?Q?Q8/Nks+C7pL9kL8+pULAeu7neWLDeruMvu19Nn5Rf0H8A6wx31XCTmytZ2XO?=
 =?us-ascii?Q?irXGogcrYCv8b82NM0W77iLuN+Ls/T8ORkTIG/3Uc0m79hy/o+1mBMwGfzAE?=
 =?us-ascii?Q?617FyNAiWqYLgCYgbaf4a5TpUOW93H5QkVwqXvuM5tfk53IWe/ka9O4ooA84?=
 =?us-ascii?Q?XIiOlD7eBoIuPrE792s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3836b33a-33fd-4724-390d-08ddfc87dd0a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 23:04:21.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5Nm/mSx2bTvquCfWiG4n4GBb1Xe01KU5VQzh2zqinhauhupIgO+ZaWme4gfRIGX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455

On Thu, Sep 25, 2025 at 02:35:19PM -0700, Sean Christopherson wrote:
> >  LDLIBS += -ldl
> > +LDLIBS += -lnuma
> 
> Hrm, this is going to be very annoying.  I don't have libnuma-dev installed on
> any of my <too many> systems, and I doubt I'm alone.  Installing the package is
> trivial, but I'm a little wary of foisting that requirement on all KVM developers
> and build bots.

Wouldn't it be great if the kselftest build system used something like
meson and could work around these little issues without breaking the
whole build ? :(

Does anyone else think this?

Every time I try to build kselftsts I just ignore all the errors the
fly by because the one bit I wanted did build properly anyhow.

Jason

