Return-Path: <linux-fsdevel+bounces-11416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CFE853A5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 19:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1193B230AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 18:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802F71CF9C;
	Tue, 13 Feb 2024 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWRPB2Gx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255E810A19;
	Tue, 13 Feb 2024 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850633; cv=fail; b=E3hZN0EU51iygcd5me82qgi2tW/lBW1abunRHD94xj+QOU05Pzx3quuAcGxnyIWct5WyvTM0UcaRjGC6x31NjZT+JU0KNojLU/SMuq1ozUdcTN4h07kKmhubYX/N10uuZRSCF/iy9STAcNca0ZJP0i4U3nsyAegFOczelHklAwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850633; c=relaxed/simple;
	bh=bZg1mwnr0HavwHHubFOlYTFkz976GN8H878yWGtteA4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bfBApfzHjiFlZ+wb6dMXE5/gTyUf1ZEcO46q5JPUOjoE/bySxjy3Q59c2JCshOl2//4z9qa/7+1D2GpkG7ogtf6lhG7qrz274QaiPKyb3OgNN/gMCHjDEkUEned5ZEpJAYsJTowinCs3xBBTFObHJiFJIP3u0ShCKLxPKeNuRNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWRPB2Gx; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707850632; x=1739386632;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bZg1mwnr0HavwHHubFOlYTFkz976GN8H878yWGtteA4=;
  b=RWRPB2GxSZa6p+LEzSP6PsS/W3K1AxfwsKMeSYy27Oova3B48eVtKFv2
   1gZfgCc2WMbyJ9ulIM4zk3/WdW7bHF2iHqgvEjMxrc8BVxQoW8nqBmHzI
   Dz4WyURo4N5kpI+BNFsdZflkWTFSyPwXDNtuy8qYug0T/uQJMRsOOrlel
   vIjwUvLZVsV9bU4CQdm6m3eCmDtbrc5v1mR1QCvRuzj1yiEUEcofL5g17
   zIMzY/BeogFqBWKXevOK3nH4g+Iqn0/HeGSS4qhf9XQfVzukcQo0IQNV8
   j35eRAwX9mV4nar4XpnlxOpGgxUQv8d+xgFROmRQ0gW9tRlkIqnWF5b1I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2018679"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="2018679"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 10:56:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="826192253"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="826192253"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 10:56:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 10:56:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 10:56:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 10:56:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp/I1s4qvbkq8T/IkqIK/9X6NNVsWAjhnd/LGPJOqsD0+M25CRI3iIzFBbjeawW9H2OQwkBOXZXrZs+me1qE9uoyADS3ohf/UAEr3y5cBqYujFaHKENz6BGUHGZxCcMqusDJHlUrxFlwUgneY4a0uXDPZbX2aDVojMTJ16FJBz0xDWY90J7sj07p38u6yV8rHZsb3xoPUKXrvpaY0wFvyzPT707/56iBa+rcWWtyhqrDvqJmVTr24Nx4HwIe4TUvqEYdT6t0Wdbx0sTtmdL/03zyFtIw9yqAQ+PpJBaHfTkfGmzkZnzryUcSNxMatLsBrTahQNH4sgCPpnzqu+8itQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdGKjsgJZNtSohmEcSM1zVdl8jCfxU+iOyZ5TLVlUbc=;
 b=i82eij/XXEkbbZsWefyd6N0gRse3IKLhdoMWN8b+grscmj8w520xfVmRlEVSCqoJ6zDGc0Kumojyz9Gs9IOV+Zx6DS7qzE2mzvRLxbhjyo7tQkP4zr9lZL2we2JIdsiJA3+6CEjqPF5FmCsig3Ng3OW3UqvK8nkNEX6VgDZoa7h+RL6haliA3IfPpzX2DQSFWaLJD8TG9nUIDWxfLxW24Fv0b5EL84MJ/OiCmxgSKsB48gHlsVvocQc+r5PS3JcOQyAQzTIeCpv9d4bPPHuu+GtyRpjZsxULKY4OZx9d2wi7Kb6jS7QbmCelUlDUhQVH5tsixxIa/xuJ+tGzPF5Ljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 18:56:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 18:56:48 +0000
Date: Tue, 13 Feb 2024 10:56:45 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Dave Chinner
	<david@fromorbit.com>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, "Russell
 King" <linux@armlinux.org.uk>, <linux-arch@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
	<dm-devel@lists.linux.dev>, <nvdimm@lists.linux.dev>,
	<linux-s390@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer
	<snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as
 non-fatal
Message-ID: <65cbbb6d24b71_5c7629450@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-6-mathieu.desnoyers@efficios.com>
 <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
 <65caa3966caa_5a7f294cf@dwillia2-xfh.jf.intel.com.notmuch>
 <20240213061823.GB27995@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240213061823.GB27995@wunner.de>
X-ClientProxiedBy: MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: a46b3185-d0ed-4d6b-56e8-08dc2cc5881c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JakRCxpZjBiFfwAZrQ0i2WEAY8WZi8qnlasOQxWRHp4ZOrDtFEhqyulVJ6V2E8+9aanK1ayQC1BlXyrsuqavyJlgyAB9wbaNZZ878dooeWFp6jxro+daTB4fbZn9n9YLBGWX6LGSJouh47ompIdyhZ4P5vO2Bp+MbY6O6DjyQtPCcxiSBojFeiCmFcNr4smwWNMC+QKoIbnFWgLY4ftA0jxxaiI2ifi00Ba2h5IUdHwGB+iL/FKIfRl9w9NC/s37X8dZ/Lxfx2t0/zv1fEr80dMGq0lxoKJ4YzbAuKFtxVVD58ls9Yk8r7L7mNi0yAOtGb3OnO7XWmmVgmv/Yme5RBpGzjMj7bmcyi7W+/wWmMu272taTo22JflgFF1SovFIb+3poYHjXjyMfzxki5ajUCVNHqGlfMZUYjsRyyAoh6Bm2g04Pz53011J/VEFPLTSM6l+Z5UmATPeF5zLRP85u9WLgVbPcqXcY7hkSql3Ku0O/QtovB9En8oDizBy4tZk2CPZr5qs531Fw1RLflh1qybvURB2bZT/Pdgyq638/kboEO8N2e8Al16Qj3ME/5q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6506007)(41300700001)(478600001)(83380400001)(66476007)(26005)(66946007)(5660300002)(66556008)(8936002)(4326008)(8676002)(6486002)(6512007)(54906003)(316002)(6666004)(9686003)(86362001)(82960400001)(38100700002)(110136005)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kSPXZl4X++sSido70YWeqI8KiBJTxCpFjuazLeOmUuWe2YvQVJ+FzzWhQa4Q?=
 =?us-ascii?Q?eNpDdgL8oyNxr1pYbENKapjX8LsDw1YEwbuWLTyjIQTu6CIpnv5PNnyy3PQG?=
 =?us-ascii?Q?QR9BU5Kqvw4k3xbPGJz1ZIv/PGW1F0rB3kD5/mw2uxmMmW2mu0Jxucrmlip/?=
 =?us-ascii?Q?6iRJuIFro+bCGlcfbJbYM4U969w6dQz+YHpQrSKbOOaioh07+MC26teHh9sX?=
 =?us-ascii?Q?nnRGzsqDE38soy3oED1ZnKhtWDA8rOEN3lw1VUBT7zUpZeX3z3zOgyXmpHHq?=
 =?us-ascii?Q?lNH24DocQiddA92S1x4Qbe3I/mKjJtjfX0KpyKMKMKHpgCDlcyvMkJO2pCzZ?=
 =?us-ascii?Q?DaC2ZZdozDQbCjXifVwFwdFqSXhGDZ18HteZbI6a8EDlvy1/xshRE+9VPDIf?=
 =?us-ascii?Q?0E8yWVuCBCqXv6q0UYos3aSkulxqSLRKCRG3cJzMPenIU6AwueGfBp17tcIA?=
 =?us-ascii?Q?lUSmJd0+6SnIk9sxtil1h8beZyCp2u5AZp+lRFLHgHgQAgvMvoS4h12x12zZ?=
 =?us-ascii?Q?0oEp0nfgTe6Y0tfWEe1xyTGp3wLVPrWaywitY/cdDGUxuHtIEj4Ko80W6Uxm?=
 =?us-ascii?Q?BkuHeVJwXylIPSp2Q9yIoxapUagv3Gajw2BAcFhgkF4ZM9HJd7JTxv7kOkaA?=
 =?us-ascii?Q?drnR7CSeu2kuU/CN2zOLPAYWAhnb0sEqhC9AL65rx+hOVHnzv5Kncf/sYFIF?=
 =?us-ascii?Q?3eqwPeQU9HuKneUDbbtOl/g/iABa7Cq51TU5uOB4BpwtViignp/TsHaks9FJ?=
 =?us-ascii?Q?a2YbLmzhMhHK/kIKlPhez38JKeQw1VWJLwDzIjDxptJRhnSiHhfUI8rRN8ok?=
 =?us-ascii?Q?d7EH7yY5sLk5Ixsq/MIA13Z9imvS4J2Qa/biDykfpEtcssA8mhgQ2CHVzpK0?=
 =?us-ascii?Q?6823zy1tEZGshlCkSWXJRkFJrwAojTz+XuurIhp21+5NTIZE3NTUgwNRunCS?=
 =?us-ascii?Q?7vg5ZVomoEV8BazEShBGH3CnjonUQedU5IdTEqL9CSLywyfVNedyBIhV8x2k?=
 =?us-ascii?Q?iJrgBBmWkySHWNiuVrhWjLLrMYOERGvVyIjPB8Y4Ebx4VtByGNgy1mNPRm7f?=
 =?us-ascii?Q?aBqELFNHpg+TyeQwTWrmQDGNx05Je9fPYHDC+68dYaJmYYTMSLkOAA2EDTId?=
 =?us-ascii?Q?uSFopZyLd4qvswm8k4RGkfMluD4gRVQtB9drAWft1Wjh7sp2XVtcWhJm1/qv?=
 =?us-ascii?Q?ihgJEc2SEp3SJPG1Fb9JTPXw82QRykcUiRB77UvHImIQR8i55BmXCbycXFxf?=
 =?us-ascii?Q?3gYLwxOHTH/n6c52NXEJBSfA4w81jQbJHfTG0Q/txXIKqkoViol7SCB7W+BR?=
 =?us-ascii?Q?wn1taWxp6MhtRkcgP5bDtafQaJQjkStyrjsvgEE1o6nLKsHw/GNYHQvKA7mK?=
 =?us-ascii?Q?R1G2cNpm4dNmmEe+VcIn04LCUFOHdWFdlC99dbPq89d8uqYJCv9ea2JXTP6u?=
 =?us-ascii?Q?qVgaHSQck4uNFMXt0jJrTV9Nb7futr+L7HO4HN+ZmNhDIM1BplXe2Wia776R?=
 =?us-ascii?Q?ERjyX9KeEOWoeVUaVdvAyP5MNwLjBwgklEjDiMxYtU5s6o64nUAey9LPa2Jl?=
 =?us-ascii?Q?4+30iYBtwlUjQUDahcPLfSZuw8wWtWDrfSQd6mERDlEEMhjpRDySXK4n4uSe?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a46b3185-d0ed-4d6b-56e8-08dc2cc5881c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 18:56:48.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64QvyNHPRdaU/kQ6jUlMZBMxqQygW2rsHZQ0qIKNCgF7u6f/LsxoGUx9Sa2talKSVapkyQsBoiNarKTLqVKZf4S0fC0HKNZw31gKtm+1O6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Mon, Feb 12, 2024 at 03:02:46PM -0800, Dan Williams wrote:
> > However, Lukas, I think Linus is right, your DEFINE_FREE() should use
> > IS_ERR_OR_NULL().
> 
> Uh... that's a negative, sir. ;)
> 
> IS_ERR_OR_NULL() results in...
> * a superfluous NULL pointer check in x509_key_preparse() and
> * a superfluous IS_ERR check in x509_cert_parse().
> 
> IS_ERR() results *only* in...
> * a superfluous IS_ERR check in x509_cert_parse().
> 
> I can get rid of the IS_ERR() check by using assume().
> 
> I can *not* get rid of the NULL pointer check because the compiler
> is compiled with -fno-delete-null-pointer-checks.  (The compiler
> seems to ignore __attribute__((returns_nonnull)) due to that.)
> 
> 
> > I.e. the problem is trying to use
> > __free(x509_free_certificate) in x509_cert_parse().
> > 
> > > --- a/crypto/asymmetric_keys/x509_cert_parser.c
> > > +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> > > @@ -60,24 +60,24 @@ void x509_free_certificate(struct x509_certificate *cert)
> > >   */
> > >  struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
> > >  {
> > > -       struct x509_certificate *cert;
> > > -       struct x509_parse_context *ctx;
> > > +       struct x509_certificate *cert __free(x509_free_certificate);
> > 
> > ...make this:
> > 
> >     struct x509_certificate *cert __free(kfree);
> 
> That doesn't work I'm afraid.  x509_cert_parse() needs
> x509_free_certificate() to be called in the error path,
> not kfree().  See the existing code in current mainline:
> 
> x509_cert_parse() populates three sub-allocations in
> struct x509_certificate (pub, sig, id) and two
> sub-sub-allocations (pub->key, pub->params).
> 
> So I'd have to add five additional local variables which
> get freed by __cleanup().  One of them (pub->key) requires
> kfree_sensitive() instead of kfree(), so I'd need an extra
> DEFINE_FREE() for that.
> 
> I haven't tried it but I suspect the result would look
> terrible and David Howells wouldn't like it.

Ugh, that's what I was afraid of, so these cases are different.

> > ...and Mathieu, this should be IS_ERR_OR_NULL() to skip an unnecessary
> > call to virtio_fs_cleanup_dax() at function exit that the compiler
> > should elide.
> 
> My recommendation is to check for !IS_ERR() in the DEFINE_FREE() clause
> and amend virtio_fs_cleanup_dax() with a "if (!dax_dev) return;" for
> defensiveness in case someone calls it with a NULL pointer.

The internal calls (kill_dax(), put_dax()) check for NULL already, so I
don't think that's needed.

> That's the best solution I could come up with for the x509_certificate
> conversion.
> 
> Note that even with superfluous checks avoided, __cleanup() causes
> gcc-12 to always generate two return paths.  It's very visible in
> the generated code that all the stack unwinding code gets duplicated
> in every function using __cleanup().  The existing Assembler code
> of x509_key_preparse() and x509_cert_parse(), without __cleanup()
> invocation, has only a single return path.

I saw that too, some NULL checks can indeed be elided with a NULL check
in the DEFINE_FREE(), but the multiple exit paths still someimtes result
in __cleanup() using functions being larger than the goto equivalent.

> So __cleanup() bloats the code regardless of superfluous checks,
> but future gcc versions might avoid that.  clang-15 generates much
> more compact code (vmlinux is a couple hundred kBytes smaller),
> but does weird things such as inlining x509_free_certificate()
> in x509_cert_parse().
> 
> As you may have guessed, I've spent an inordinate amount of time
> down that rabbit hole. ;(

Hey, this is new and interesting stuff, glad we are grappling with it at
this level.

