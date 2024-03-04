Return-Path: <linux-fsdevel+bounces-13422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2459E86F95B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 06:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F8628177B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 05:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619B063D9;
	Mon,  4 Mar 2024 05:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kU9QFIiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3017F3;
	Mon,  4 Mar 2024 05:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709528795; cv=fail; b=JUZdM7EvCne0t1kLn1gWI+eCiY/oEHt4+q/3ckuKB+VKh43M9bYekdDt5pqCHv2urBAXc6g/CbBxM/2dAfPmsgH4UHjjrhTguZrlNHBNbbXzqv5zNrse37/H/2a1XfzeittXdaHkQlKGAeUUZgvMcXQxqFBK8qk3u3BgTsg807s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709528795; c=relaxed/simple;
	bh=u15JjpQ6PgvWxfVbJ4Ao/+ituUHlawEn2DSAExA+qU0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fiMM2y1oSQrq3+xFKlT2NpvFexy4LYBpuQCeVK3AW1LjYfCmOymr3XJ22NT+hpw6VSFJJg5/Kk4SFtxyG5WqlRUueuV2hkcHkfXuYgwt6FVSuWAtWFkts/0WI+vCoh3sqaUyFLkYWPCD6YB71SrH4NtVpb1uCr5d4CWwCYRxiKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kU9QFIiv; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709528792; x=1741064792;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=u15JjpQ6PgvWxfVbJ4Ao/+ituUHlawEn2DSAExA+qU0=;
  b=kU9QFIivUVz0yDwf47ucfF5DhQ/DY8oKbUp5zA48PxwEhckz7ddmSkm+
   kL1MoUBCWnOD4zC+Ih1Vi65FlOHfU7decYM/XZgdhIROm7O7B/Fv29HZL
   I6oAfJhSYPGO5b5lVoWVIz0UA2OKqCl1SYlg+E6czxXJlojLIBbNplz1O
   Kmd7433T8rOtfzSL6YJqlbU2QJQ7fDoQxxbA4oaN49hMeaLKqziKd+XLI
   M2Or1ai4QlGM7qjyZaoThOVdNw+sC4JEPUIuky73kNAcCfGlpFUcY3G3E
   Mqbj0n36Cw2iDVj1m5AbBZLLl2BagJtTmg4eeS6ytTaxZp8z3WYm/ioh2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4127283"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4127283"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 21:06:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9060659"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2024 21:06:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 21:06:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 3 Mar 2024 21:06:30 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 3 Mar 2024 21:06:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSrqLu+hIK3BnFHaCZwRJBwZAm/LbrYn305GN55Uf8Cv29Pn/4WQqRb2uQyZEQstU/ePMIsg4x86lNEcfhHCAMJ809zOO+SBOySCX8roPln80bESJGOnJ1XTuie+SEkukPcORPRHZWjlaMX4+7oCbWsja0kaDuGFPWxL0CG/2mHzTwR9DBR+JgJZlR1utbrE7DuEaxOYBlHLklqgna6GCAVezGppiNC2nssyhvLu2oglYePKG+KbGgVyczwT01M5LiDm4loAbmGeS7At2UOJ6UeshpZ1ilfJFIPY7gDzdkNi7JOk/m3tCtx7IkmwgEiztC8YWvkwU/m3oTnb1yfvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svEO4xd5laAFaPRkEbstK/MOLIin5ZDGJbqDB737JUk=;
 b=Dr5bvTA5//hBb91uunZn94Edi7dqi1/pEiNN3+gDaOuyvdlp2Rv7UnA5SOLttdxGatz6bQ3YQioEJwC8qNP5i56O1AjJXPoeVaPMCMe/p+Rc31iciclxIYcf8D2e5uNj/7hDEnZyEtlmyzfjWYHM3HLvNvd5TVVvTZSd3nQ5v8lnezLkaF2ZRNQbufXecgi3sTgTcpJQIChJEhANymn+5jLW2lfi9RvNHcjpcjzvL0BLBt7sJWwRBwvQ3b5ZKNwmd0lZeSDdgP9ntZy9do+/sWBef7b7wpeSdLMrpGgwvZXraLh7xlwTB4g85gErb4Om511pxJh0AHDZQ8ZzZp7waA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS7PR11MB6246.namprd11.prod.outlook.com (2603:10b6:8:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 05:06:27 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%5]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 05:06:27 +0000
Date: Mon, 4 Mar 2024 12:59:35 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Jan Kara <jack@suse.cz>
CC: Oliver Sang <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Guo Xuenan
	<guoxuenan@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: Re: [linus:master] [readahead]  ab4443fe3c:
 vm-scalability.throughput -21.4% regression
Message-ID: <ZeVVN75kh9Ey4M4G@yujie-X299>
References: <202402201642.c8d6bbc3-oliver.sang@intel.com>
 <20240221111425.ozdozcbl3konmkov@quack3>
 <ZdakRFhEouIF5o6D@xsang-OptiPlex-9020>
 <20240222115032.u5h2phfxpn77lu5a@quack3>
 <20240222183756.td7avnk2srg4tydu@quack3>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222183756.td7avnk2srg4tydu@quack3>
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS7PR11MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: b73dc7d3-09e2-42ab-253c-08dc3c08d8d0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htMaTtGFbsnsDreFP8WDAy2XZxXqNjzbzAvaDa5CrBN255jd3IJ3ytgh1kst1Ni4XGfFjcCNdLap5pgqQqgpPQYXdnX6JNIcU+OIfON4UsYOwcvHXG3KjxwRYFxswuPz6Qh9mzw+2m4FdYvP3y2RYB5CL6PEu4elYFKz3db6D8vlLZ2Ly58207GW9ctqvy0zyqqRBi0eoTXF+UpAN7I7uCcXnAA/RoXmmN2OsqAnlj0kb87aabmHITDjXQLovEeusKAQeB9Low3GRXyabmlroMrbSqtplfNrVkezPEmr3BOVKN6ADgEow1dg1TCZWpdOsdf5UW0+TSK2rhZ6WvpNEMmcAV+o/+H6VEUMw28iK3WI9NArg8Y7Fj7YjXSogOTvET8BXXucXpHn5OYDvkzQNdKqxZ0Qnej+cbgRBapTaxH66T3/rtXpN3Au8IGRUFkTuUPWUmWm+vXAeodCLnzCxOOApjthVvCS6tfeZ7o+Zc5jlfdLGLtrRxr9HBq0Iv7DyaO/BXociVAFH65SYNpebu0AR8Z7cfZnCrPTZmON6+33YgU1R+wZo8SZH0FVgZW2X2Rwq7wPWhhb+Da6ptGH9/fiHewwq6IoJu7HkyrlByg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QFcmQJWJbB+Z+qNhwzC0nBVT7IPCiQ7/2qH+HUTzv+BkOF9WHthVMVD5fE?=
 =?iso-8859-1?Q?bh9X/ZRdagBbO4o36cIy4HUC9Gw8zwVBsT7ZqPbLymlb4bHHxEsWu5xiy/?=
 =?iso-8859-1?Q?GTARD12sBINSeYMny0OyBH4tBPJZN6zqpPlADIg7OMPMemE6Cpb6ngD7d9?=
 =?iso-8859-1?Q?mBuHIkfrNSdR+jA1JPW3IGF/VuWq9zGwfj+EzXDy3hcfs/gV5Va1hBa6Np?=
 =?iso-8859-1?Q?QHC3y07MxTD/5Wac3SEhUaNu6xi6ZlkmxGco0AI55gAz3NV2+xmi3qr8a0?=
 =?iso-8859-1?Q?5hu1ETnPQsa+awunMDABO3DdHHBcfxV6j06G2if/HZZr2sv+l2gaAEnV+W?=
 =?iso-8859-1?Q?eeURX6s/kI4YofuR5N2Lu0hcggevu7+aShLPJjjmc+bgqn3GZrCgGVC5Pc?=
 =?iso-8859-1?Q?76fQglPmffVQcyL3AxivYW+Ei41WlU9ukIOLyBK/R3unzL9CyYeAhh+0x8?=
 =?iso-8859-1?Q?O7SZqbtx02lmSdvLpMAamo15R38ay4eRCNxTSpeVLWqSNgjM1O5lsGm5r/?=
 =?iso-8859-1?Q?G5X9KpxXGSoGxX8yNhh36am+BHhOQfwktPOe3WTR8iYkY54bLGLBdHe2z0?=
 =?iso-8859-1?Q?lG0P40Y6qIt2Ah/Jr6rzQomLFYP2lvebkZ/9bGcRhN+J9rSL82ewqImTC+?=
 =?iso-8859-1?Q?OiFRxCzpLSozxdpb4mjTxjnEJs4zrJjS9PlgZ4zYMfOJkTmXPSkzum/6Dd?=
 =?iso-8859-1?Q?79KsDc37IoLj42DLT9u32vCwuTF00PUFRdtVFabEYqYwcML//Q057ltCjU?=
 =?iso-8859-1?Q?9oaIN6VGrhsWQNToPyO3TdtzlR/Kh6NJzsxkRmidXaD2U7114AcyPqEQnu?=
 =?iso-8859-1?Q?cXwjSv1IAVgJOVmMEtjxzDyCaCMEpeN93VCBnT0ar5zMiiIcHepsJJIbyn?=
 =?iso-8859-1?Q?KyLKzcmhJzlN8It4agjKCyhez8liUfxslvq3VGvxFgU8RtkJMlfraBPCg0?=
 =?iso-8859-1?Q?PM3rtIwtOMtMJGG4unmQw9fmD65hM30+4/0eC6J9LfDp/cTVbIRVaFmg3z?=
 =?iso-8859-1?Q?E94vMf6ohS0bI9ZXpJFlClZoVEc2hCILYFmeGJEHZcQP5J7cEkJEUnTe47?=
 =?iso-8859-1?Q?2dbDREPqu8Pf1MoBILpLXUAT74pGHPGVU5LKzo53wRPumjHMmd33oIEbn9?=
 =?iso-8859-1?Q?xR9oZ6wjX5FJZKsLJ1pCloII8EnZKB45o1NYanxsI3puZXB7FUYa5aOYTW?=
 =?iso-8859-1?Q?tT+S9PUAOHNCzYdrOeOeBV888Ntplrgyxq2lTuwDXVYZIp4ulptPDp1jME?=
 =?iso-8859-1?Q?seZWMBUiUlVXnTGjTcfF6SIDjKieKSQtyV54TVtcBPNgaGgYI3D7pI/OaY?=
 =?iso-8859-1?Q?7DGdm9v4CSKX84zGJfytBT3yAgbcM3Br4lHQpI00hLEaofve83eMvKfZdH?=
 =?iso-8859-1?Q?F6JRpZkL1I27WXLnoAg4KDyKl9rtamv83RnDhzp+PszkJdOyih/52KyaZB?=
 =?iso-8859-1?Q?vkoUVYUaC1xu8MPzXvXXf7rYjpd0IEipL0UsfTb51GuSY+qK5Xm+KkrSF2?=
 =?iso-8859-1?Q?a2N8TYgXAsMyTbeQcWujvC2Do1TRcg6r/lDkT7AteNzKpMrAeyp51Mg5GU?=
 =?iso-8859-1?Q?eVYsGU1vF+dfWS1DNMmTSUPu7NzG9cMjDvmT2ONtCR6u0g/HQ6/hNDvgq1?=
 =?iso-8859-1?Q?bPby1dvt7/hyjFVUxoNuJ8DmCeTgaZjvut?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b73dc7d3-09e2-42ab-253c-08dc3c08d8d0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 05:06:27.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SzLS2K4WJzgcOo9sYNi5hROrJqlhFu9r05RbDOybwpGFopwbGELHHm7+PE/nmdqV74icEwTJNQv7LMroXhzqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6246
X-OriginatorOrg: intel.com

Hi Honza,

On Thu, Feb 22, 2024 at 07:37:56PM +0100, Jan Kara wrote:
> On Thu 22-02-24 12:50:32, Jan Kara wrote:
> > On Thu 22-02-24 09:32:52, Oliver Sang wrote:
> > > On Wed, Feb 21, 2024 at 12:14:25PM +0100, Jan Kara wrote:
> > > > On Tue 20-02-24 16:25:37, kernel test robot wrote:
> > > > > kernel test robot noticed a -21.4% regression of vm-scalability.throughput on:
> > > > > 
> > > > > commit: ab4443fe3ca6298663a55c4a70efc6c3ce913ca6 ("readahead: avoid multiple marked readahead pages")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > > 
> > > > > testcase: vm-scalability
> > > > > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
> > > > > parameters:
> > > > > 
> > > > > 	runtime: 300s
> > > > > 	test: lru-file-readtwice
> > > > > 	cpufreq_governor: performance
> > > > 
> > > > JFYI I had a look into this. What the test seems to do is that it creates
> > > > image files on tmpfs, loopmounts XFS there, and does reads over file on
> > > > XFS. But I was not able to find what lru-file-readtwice exactly does,
> > > > neither I was able to reproduce it because I got stuck on some missing Ruby
> > > > dependencies on my test system yesterday.
> > > 
> > > what's your OS?
> > 
> > I have SLES15-SP4 installed in my VM. What was missing was 'git' rubygem
> > which apparently is not packaged at all and when I manually installed it, I
> > was still hitting other problems so I rather went ahead and checked the
> > vm-scalability source and wrote my own reproducer based on that.
> > 
> > I'm now able to reproduce the regression in my VM so I'm investigating...
> 
> So I was experimenting with this. What the test does is it creates as many
> files as there are CPUs, files are sized so that their total size is 8x the
> amount of available RAM. For each file two tasks are started which
> sequentially read the file from start to end. Trivial repro from my VM with
> 8 CPUs and 64GB of RAM is like:
> 
> truncate -s 60000000000 /dev/shm/xfsimg
> mkfs.xfs /dev/shm/xfsimg
> mount -t xfs -o loop /dev/shm/xfsimg /mnt
> for (( i = 0; i < 8; i++ )); do truncate -s 60000000000 /mnt/sparse-file-$i; done
> echo "Ready..."
> sleep 3
> echo "Running..."
> for (( i = 0; i < 8; i++ )); do
> 	dd bs=4k if=/mnt/sparse-file-$i of=/dev/null &
> 	dd bs=4k if=/mnt/sparse-file-$i of=/dev/null &
> done 2>&1 | grep "copied"
> wait
> umount /mnt
> 
> The difference between slow and fast runs seems to be in the amount of
> pages reclaimed with direct reclaim - after commit ab4443fe3c we reclaim
> about 10% of pages with direct reclaim, before commit ab4443fe3c only about
> 1% of pages is reclaimed with direct reclaim. In both cases we reclaim the
> same amount of pages corresponding to the total size of files so it isn't
> the case that we would be rereading one page twice.
> 
> I suspect the reclaim difference is because after commit ab4443fe3c we
> trigger readahead somewhat earlier so our effective workingset is somewhat
> larger. This apparently gives harder time to kswapd and we end up with
> direct reclaim more often.
> 
> Since this is a case of heavy overload on the system, I don't think the
> throughput here matters that much and AFAICT the readahead code does
> nothing wrong here. So I don't think we need to do anything here.

Thanks a lot for the analysis. Seems we can abstract two factors that
may affect the throughput:

1. The benchmark itself is "dd" from a file to null, which is basically
a sequential operation, so the earlier readahead should bring benefit
to the throughput.

2. The earlier readahead somewhat enlarges the workingset and causes
more often direct memory reclaim, which may hurt the throughput.

We did another round of test. Our machine has 512GB RAM, now we set
the total file size to 256GB so that all the files can be fully loaded
into the memory and there will be no reclaim anymore. This eliminates
the impact of factor 2, but unexpectedly, we still see a -42.3%
throughput regression after commit ab4443fe3c.

From the perf profile, we can see that the contention of folio lru lock
becomes more intense. We also did a simple one-file "dd" test. Looks
like it is more likely that low-order folios are allocated after commit
ab4443fe3c (Fengwei will help provide the data soon). Therefore, the
average folio size decreases while the total folio amount increases,
which leads to touching lru lock more often.

Please kindly check the detailed metrics below:

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/cpufreq_governor/debug-setup:
  lkp-spr-2sp4/vm-scalability/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/300s/lru-file-readtwice/performance/256GB-perf

commit:
  f0b7a0d1d466 ("Merge branch 'master' into mm-hotfixes-stable")
  ab4443fe3ca6 ("readahead: avoid multiple marked readahead pages")

f0b7a0d1d46625db ab4443fe3ca6298663a55c4a70e
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
      0.00 ± 49%      -0.0        0.00        mpstat.cpu.all.iowait%
      8.43 ±  2%      +3.6       12.06 ±  5%  mpstat.cpu.all.sys%
      0.31            -0.0        0.27 ±  2%  mpstat.cpu.all.usr%
   2289863 ±  8%     +55.6%    3563274 ±  7%  numa-numastat.node0.local_node
   2375395 ±  6%     +54.4%    3666799 ±  6%  numa-numastat.node0.numa_hit
   2311189 ±  7%     +53.8%    3554903 ±  6%  numa-numastat.node1.local_node
   2454386 ±  6%     +50.1%    3684288 ±  4%  numa-numastat.node1.numa_hit
    300.98           +25.2%     376.84 ±  4%  vmstat.memory.buff
  46333305           +27.5%   59075372 ±  3%  vmstat.memory.cache
     25.22 ±  4%     +51.4%      38.18 ±  6%  vmstat.procs.r
    303089            +8.0%     327220        vmstat.system.in
     29.30           +13.5%      33.27        time.elapsed_time
     29.30           +13.5%      33.27        time.elapsed_time.max
     33780 ± 16%     +94.4%      65660 ±  7%  time.involuntary_context_switches
      1943 ±  2%     +42.4%       2767 ±  5%  time.percent_of_cpu_this_job_got
    554.77 ±  3%     +63.5%     907.13 ±  6%  time.system_time
     14.90            -3.3%      14.40        time.user_time
     20505 ± 11%     -41.1%      12085 ±  8%  time.voluntary_context_switches
    284.00 ±  3%     +34.8%     382.75 ±  5%  turbostat.Avg_MHz
     10.08 ±  2%      +3.6       13.65 ±  4%  turbostat.Busy%
     39.50 ±  2%      -1.8       37.68        turbostat.C1E%
      0.38 ±  9%     -17.3%       0.31 ± 14%  turbostat.CPU%c6
   9577640           +22.3%   11715251 ±  2%  turbostat.IRQ
      4.88 ± 12%      -3.7        1.15 ± 48%  turbostat.PKG_%
      5558 ±  5%     +41.9%       7887 ±  6%  turbostat.POLL
    790616 ±  6%     -43.9%     443300 ±  7%  vm-scalability.median
     12060 ±  7%   +3811.3       15871 ±  4%  vm-scalability.stddev%
 3.681e+08 ±  7%     -42.3%  2.122e+08 ±  7%  vm-scalability.throughput
     33780 ± 16%     +94.4%      65660 ±  7%  vm-scalability.time.involuntary_context_switches
      1943 ±  2%     +42.4%       2767 ±  5%  vm-scalability.time.percent_of_cpu_this_job_got
    554.77 ±  3%     +63.5%     907.13 ±  6%  vm-scalability.time.system_time
     20505 ± 11%     -41.1%      12085 ±  8%  vm-scalability.time.voluntary_context_switches
  21390979 ±  4%     +31.7%   28175360 ± 19%  numa-meminfo.node0.Active
  21388266 ±  4%     +31.7%   28172516 ± 19%  numa-meminfo.node0.Active(file)
  24037883 ±  6%     +31.1%   31516721 ± 17%  numa-meminfo.node0.FilePages
    497645 ± 25%     +82.4%     907626 ± 38%  numa-meminfo.node0.Inactive(file)
  25952309 ±  6%     +29.2%   33533454 ± 16%  numa-meminfo.node0.MemUsed
     20138 ±  9%    +154.2%      51187 ± 11%  numa-meminfo.node1.Active(anon)
    704324 ± 17%     +85.4%    1306147 ± 33%  numa-meminfo.node1.Inactive
    427031 ± 22%    +141.7%    1031971 ± 41%  numa-meminfo.node1.Inactive(file)
  43712836           +27.4%   55698257 ±  2%  meminfo.Active
     22786 ±  6%    +136.6%      53907 ± 11%  meminfo.Active(anon)
  43690049           +27.4%   55644350 ±  2%  meminfo.Active(file)
  47543418           +27.4%   60583554 ±  2%  meminfo.Cached
   1454581 ± 10%     +72.8%    2513041 ± 11%  meminfo.Inactive
    929099 ± 16%    +109.5%    1946433 ± 14%  meminfo.Inactive(file)
    242993           +12.9%     274324        meminfo.KReclaimable
     79132 ±  2%     +34.8%     106631 ±  2%  meminfo.Mapped
  51363725           +25.6%   64520957 ±  2%  meminfo.Memused
      9840           +12.2%      11041 ±  2%  meminfo.PageTables
    242993           +12.9%     274324        meminfo.SReclaimable
    136679           +50.2%     205224 ±  5%  meminfo.Shmem
  72281513 ±  2%     +25.8%   90925817 ±  2%  meminfo.max_used_kB
   5346609 ±  4%     +31.7%    7042196 ± 19%  numa-vmstat.node0.nr_active_file
   6008637 ±  7%     +31.1%    7878524 ± 17%  numa-vmstat.node0.nr_file_pages
    123918 ± 25%     +83.2%     227064 ± 38%  numa-vmstat.node0.nr_inactive_file
   5346510 ±  4%     +31.7%    7042147 ± 19%  numa-vmstat.node0.nr_zone_active_file
    123908 ± 25%     +83.3%     227063 ± 38%  numa-vmstat.node0.nr_zone_inactive_file
   2375271 ±  6%     +54.4%    3666818 ±  6%  numa-vmstat.node0.numa_hit
   2289740 ±  8%     +55.6%    3563294 ±  7%  numa-vmstat.node0.numa_local
      5043 ±  9%    +153.9%      12803 ± 11%  numa-vmstat.node1.nr_active_anon
    106576 ± 22%    +141.7%     257597 ± 41%  numa-vmstat.node1.nr_inactive_file
      5043 ±  9%    +153.9%      12803 ± 11%  numa-vmstat.node1.nr_zone_active_anon
    106574 ± 22%    +141.7%     257604 ± 41%  numa-vmstat.node1.nr_zone_inactive_file
   2454493 ±  6%     +50.1%    3684201 ±  4%  numa-vmstat.node1.numa_hit
   2311296 ±  7%     +53.8%    3554816 ±  6%  numa-vmstat.node1.numa_local
      5701 ±  6%    +136.5%      13486 ± 11%  proc-vmstat.nr_active_anon
  10923519           +27.3%   13904109 ±  2%  proc-vmstat.nr_active_file
  11886157           +27.4%   15138396 ±  2%  proc-vmstat.nr_file_pages
  1.19e+08            -2.8%  1.157e+08        proc-vmstat.nr_free_pages
    131227            +8.1%     141868        proc-vmstat.nr_inactive_anon
    231610 ± 16%    +109.7%     485756 ± 14%  proc-vmstat.nr_inactive_file
     19793 ±  2%     +34.7%      26668 ±  2%  proc-vmstat.nr_mapped
      2455           +12.3%       2758 ±  2%  proc-vmstat.nr_page_table_pages
     34038 ±  2%     +51.4%      51526 ±  5%  proc-vmstat.nr_shmem
     60753           +12.9%      68588        proc-vmstat.nr_slab_reclaimable
    113209            +5.9%     119837        proc-vmstat.nr_slab_unreclaimable
      5701 ±  6%    +136.5%      13486 ± 11%  proc-vmstat.nr_zone_active_anon
  10923517           +27.3%   13904109 ±  2%  proc-vmstat.nr_zone_active_file
    131227            +8.1%     141868        proc-vmstat.nr_zone_inactive_anon
    231612 ± 16%    +109.7%     485757 ± 14%  proc-vmstat.nr_zone_inactive_file
    162.75 ± 79%    +552.8%       1062 ± 72%  proc-vmstat.numa_hint_faults
   4831171 ±  4%     +52.2%    7352661 ±  4%  proc-vmstat.numa_hit
   4602441 ±  5%     +54.7%    7119707 ±  4%  proc-vmstat.numa_local
    128.75 ± 59%    +527.5%     807.88 ± 31%  proc-vmstat.numa_pages_migrated
  69656618            -1.5%   68615309        proc-vmstat.pgalloc_normal
    672926            +3.0%     692907        proc-vmstat.pgfault
    128.75 ± 59%    +527.5%     807.88 ± 31%  proc-vmstat.pgmigrate_success
     31089            +3.7%      32235        proc-vmstat.pgreuse
      0.77 ±  2%      -0.0        0.74 ±  2%  perf-stat.i.branch-miss-rate%
     23.58 ±  6%      +3.6       27.18 ±  4%  perf-stat.i.cache-miss-rate%
      2.74            +6.0%       2.90        perf-stat.i.cpi
 5.887e+10 ±  7%     +28.6%  7.572e+10 ± 10%  perf-stat.i.cpu-cycles
     10194 ±  3%      -9.5%       9226 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.44            -2.7%       0.43        perf-stat.i.ipc
      0.25 ± 11%     +29.9%       0.32 ± 11%  perf-stat.i.metric.GHz
     17995 ±  2%      -9.0%      16374 ±  3%  perf-stat.i.minor-faults
     17995 ±  2%      -9.0%      16374 ±  3%  perf-stat.i.page-faults
     17.09           -16.1%      14.34 ±  2%  perf-stat.overall.MPKI
      0.32            -0.0        0.29        perf-stat.overall.branch-miss-rate%
     82.93            -2.1       80.88        perf-stat.overall.cache-miss-rate%
      3.55 ±  2%     +28.9%       4.58 ±  3%  perf-stat.overall.cpi
    207.81 ±  2%     +53.7%     319.49 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±  4%      +0.0        0.01 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  3%      +0.0        0.01 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
      0.28 ±  2%     -22.3%       0.22 ±  3%  perf-stat.overall.ipc
    967.32           +21.5%       1175 ±  2%  perf-stat.overall.path-length
 3.648e+09            +9.0%  3.976e+09        perf-stat.ps.branch-instructions
 2.987e+08           -10.6%   2.67e+08        perf-stat.ps.cache-misses
 3.602e+08            -8.4%  3.301e+08        perf-stat.ps.cache-references
 6.207e+10 ±  2%     +37.3%  8.524e+10 ±  4%  perf-stat.ps.cpu-cycles
    356765 ±  4%     +14.6%     408833 ±  4%  perf-stat.ps.dTLB-load-misses
 4.786e+09            +5.2%  5.034e+09        perf-stat.ps.dTLB-loads
    222451 ±  2%      +6.7%     237255 ±  2%  perf-stat.ps.dTLB-store-misses
 2.207e+09            -7.4%  2.043e+09        perf-stat.ps.dTLB-stores
 1.748e+10            +6.5%  1.862e+10        perf-stat.ps.instructions
     17777            -9.3%      16117 ±  2%  perf-stat.ps.minor-faults
     17778            -9.3%      16118 ±  2%  perf-stat.ps.page-faults
 5.193e+11           +21.5%   6.31e+11 ±  2%  perf-stat.total.instructions
     12.70            -7.9        4.85 ± 38%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.vfs_read
     12.53            -7.8        4.76 ± 38%  perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
      8.68            -5.2        3.46 ± 38%  perf-profile.calltrace.cycles-pp.read_pages.page_cache_ra_order.filemap_get_pages.filemap_read.xfs_file_buffered_read
      8.13            -4.7        3.38 ±  9%  perf-profile.calltrace.cycles-pp.zero_user_segments.iomap_readpage_iter.iomap_readahead.read_pages.page_cache_ra_order
      8.67            -4.7        3.93 ±  8%  perf-profile.calltrace.cycles-pp.iomap_readahead.read_pages.page_cache_ra_order.filemap_get_pages.filemap_read
      8.51            -4.7        3.81 ±  8%  perf-profile.calltrace.cycles-pp.iomap_readpage_iter.iomap_readahead.read_pages.page_cache_ra_order.filemap_get_pages
      7.84            -4.6        3.28 ±  8%  perf-profile.calltrace.cycles-pp.__memset.zero_user_segments.iomap_readpage_iter.iomap_readahead.read_pages
      6.47 ±  2%      -2.1        4.39 ±  5%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      6.44 ±  2%      -2.1        4.36 ±  5%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.44 ±  2%      -2.1        4.36 ±  5%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      6.43 ±  2%      -2.1        4.36 ±  5%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.39 ±  2%      -2.1        4.33 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.08 ±  2%      -2.0        4.11 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      5.85 ±  2%      -1.9        3.96 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      3.96 ±  2%      -1.3        2.62 ±  6%  perf-profile.calltrace.cycles-pp.write
      3.50 ±  2%      -1.1        2.36 ±  6%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.28 ±  2%      -1.1        2.22 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      2.76 ±  3%      -0.9        1.86 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      2.63 ±  3%      -0.8        1.79 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.37 ±  2%      -0.8        1.57 ±  6%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      2.30 ±  2%      -0.8        1.52 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      2.34 ±  4%      -0.7        1.61 ±  7%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.91 ±  3%      -0.7        1.26 ±  7%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.04 ±  4%      -0.6        1.43 ±  7%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.32 ±  2%      -0.6        0.71 ± 38%  perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
      1.68 ±  4%      -0.6        1.09 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.48 ±  3%      -0.5        0.98 ±  6%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.47 ±  3%      -0.5        0.98 ±  6%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
      1.29 ±  3%      -0.4        0.87 ±  5%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      1.46 ± 11%      -0.4        1.07 ± 38%  perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail
      1.46 ± 11%      -0.4        1.07 ± 38%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail
      1.46 ± 11%      -0.4        1.07 ± 38%  perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
      1.46 ± 11%      -0.4        1.07 ± 38%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit
      1.46 ± 11%      -0.4        1.07 ± 38%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
      1.43 ± 11%      -0.4        1.04 ± 38%  perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm
      1.13 ±  3%      -0.4        0.76 ±  6%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.02            -0.3        0.70 ±  5%  perf-profile.calltrace.cycles-pp.intel_idle_xstate.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.94 ±  3%      -0.3        0.65 ±  5%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.92 ±  3%      -0.3        0.63 ±  5%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      1.58 ± 12%      -0.3        1.29 ±  3%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.74 ±  4%      -0.3        0.46 ± 38%  perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.page_cache_ra_order.filemap_get_pages.filemap_read
      1.56 ± 12%      -0.3        1.29 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.55 ± 12%      -0.3        1.28 ±  3%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      1.55 ± 12%      -0.3        1.28 ±  3%  perf-profile.calltrace.cycles-pp.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      1.65 ± 11%      -0.3        1.38 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.65 ± 11%      -0.3        1.38 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.65 ± 11%      -0.3        1.38 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      1.46 ± 11%      -0.2        1.22 ±  3%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty
      1.46 ± 11%      -0.2        1.22 ±  3%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
      1.46 ± 11%      -0.2        1.22 ±  3%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      1.47 ± 11%      -0.2        1.22 ±  3%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      1.03 ±  7%      -0.2        0.82 ±  8%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.vfs_write.ksys_write.do_syscall_64
      1.03 ±  7%      -0.2        0.82 ±  8%  perf-profile.calltrace.cycles-pp.devkmsg_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.03 ±  7%      -0.2        0.82 ±  8%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write.ksys_write
      1.02 ±  7%      -0.2        0.82 ±  8%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write
      1.02 ±  7%      -0.2        0.82 ±  8%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write
      0.61 ±  5%      -0.1        0.55 ±  4%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
     86.32            +4.1       90.42        perf-profile.calltrace.cycles-pp.read
     85.08            +4.6       89.66        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     84.96            +4.6       89.58        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     84.63            +4.7       89.38        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     84.36            +4.9       89.21        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     26.79            +9.3       36.06 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate
     26.94            +9.3       36.22 ±  2%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed.filemap_read
     26.87            +9.3       36.17 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed
     26.91           +10.9       37.78 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     27.00           +10.9       37.89 ±  2%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio.page_cache_ra_order
     26.99           +10.9       37.89 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio
     27.44           +10.9       38.36 ±  2%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.filemap_add_folio.page_cache_ra_order.filemap_get_pages
     27.47           +10.9       38.39 ±  2%  perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.page_cache_ra_order.filemap_get_pages.filemap_read
     12.72            -7.2        5.56 ±  7%  perf-profile.children.cycles-pp.copy_page_to_iter
     12.56            -7.1        5.46 ±  7%  perf-profile.children.cycles-pp._copy_to_iter
      8.80            -4.9        3.95 ±  8%  perf-profile.children.cycles-pp.read_pages
      8.78            -4.8        3.94 ±  8%  perf-profile.children.cycles-pp.iomap_readahead
      8.62            -4.8        3.83 ±  8%  perf-profile.children.cycles-pp.iomap_readpage_iter
      8.15            -4.8        3.39 ±  9%  perf-profile.children.cycles-pp.zero_user_segments
      8.07            -4.7        3.36 ±  9%  perf-profile.children.cycles-pp.__memset
      6.47 ±  2%      -2.1        4.39 ±  5%  perf-profile.children.cycles-pp.cpu_startup_entry
      6.47 ±  2%      -2.1        4.39 ±  5%  perf-profile.children.cycles-pp.do_idle
      6.47 ±  2%      -2.1        4.39 ±  5%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      6.44 ±  2%      -2.1        4.36 ±  5%  perf-profile.children.cycles-pp.start_secondary
      6.42 ±  2%      -2.1        4.36 ±  5%  perf-profile.children.cycles-pp.cpuidle_idle_call
      6.10 ±  2%      -2.0        4.13 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter
      6.10 ±  2%      -2.0        4.13 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter_state
      4.53 ±  2%      -1.5        2.98 ±  6%  perf-profile.children.cycles-pp.write
      4.34 ±  2%      -1.4        2.90 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      3.93 ±  2%      -1.3        2.66 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      2.96 ±  2%      -1.0        1.99 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.89 ±  2%      -1.0        1.94 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      2.46 ±  3%      -0.8        1.64 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      2.47 ±  3%      -0.8        1.72 ±  7%  perf-profile.children.cycles-pp.ksys_write
      2.18 ±  3%      -0.7        1.43 ±  7%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      1.96 ±  2%      -0.7        1.31 ±  5%  perf-profile.children.cycles-pp.tick_sched_handle
      1.96 ±  2%      -0.7        1.30 ±  5%  perf-profile.children.cycles-pp.update_process_times
      2.20 ±  3%      -0.6        1.55 ±  7%  perf-profile.children.cycles-pp.vfs_write
      1.74 ±  2%      -0.6        1.17 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      1.35 ±  2%      -0.5        0.82 ±  5%  perf-profile.children.cycles-pp.filemap_get_read_batch
      1.38 ±  2%      -0.5        0.88 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.48 ± 17%      -0.4        0.05 ± 42%  perf-profile.children.cycles-pp.page_cache_ra_unbounded
      0.69 ±  7%      -0.4        0.27 ± 39%  perf-profile.children.cycles-pp.xfs_ilock
      0.82 ±  4%      -0.4        0.40 ±  7%  perf-profile.children.cycles-pp.touch_atime
      1.46 ± 11%      -0.4        1.07 ± 38%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      1.46 ± 11%      -0.4        1.07 ± 38%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      0.77 ±  5%      -0.4        0.38 ±  7%  perf-profile.children.cycles-pp.atime_needs_update
      1.22 ±  2%      -0.4        0.84 ±  5%  perf-profile.children.cycles-pp.perf_event_task_tick
      1.21 ±  2%      -0.4        0.83 ±  5%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      1.14 ±  3%      -0.4        0.76 ±  6%  perf-profile.children.cycles-pp.intel_idle
      0.65 ±  8%      -0.4        0.28 ±  9%  perf-profile.children.cycles-pp.down_read
      1.02 ±  2%      -0.3        0.70 ±  5%  perf-profile.children.cycles-pp.intel_idle_xstate
      0.79 ±  2%      -0.3        0.49 ±  5%  perf-profile.children.cycles-pp.rw_verify_area
      1.58 ± 12%      -0.3        1.29 ±  3%  perf-profile.children.cycles-pp.worker_thread
      1.56 ± 12%      -0.3        1.29 ±  4%  perf-profile.children.cycles-pp.process_one_work
      1.55 ± 12%      -0.3        1.28 ±  3%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      1.55 ± 12%      -0.3        1.28 ±  3%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
      1.65 ± 11%      -0.3        1.38 ±  3%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.65 ± 11%      -0.3        1.38 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      1.65 ± 11%      -0.3        1.38 ±  3%  perf-profile.children.cycles-pp.kthread
      0.68 ±  2%      -0.3        0.43 ±  7%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.46 ± 11%      -0.2        1.22 ±  3%  perf-profile.children.cycles-pp.drm_fb_memcpy
      1.46 ± 11%      -0.2        1.22 ±  3%  perf-profile.children.cycles-pp.memcpy_toio
      0.77 ±  4%      -0.2        0.52 ±  4%  perf-profile.children.cycles-pp.__filemap_add_folio
      1.46 ± 11%      -0.2        1.22 ±  3%  perf-profile.children.cycles-pp.commit_tail
      1.46 ± 11%      -0.2        1.22 ±  3%  perf-profile.children.cycles-pp.drm_atomic_commit
      1.46 ± 11%      -0.2        1.22 ±  3%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      1.46 ± 11%      -0.2        1.22 ±  3%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      1.46 ± 11%      -0.2        1.22 ±  3%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
      1.47 ± 11%      -0.2        1.22 ±  3%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.62 ±  3%      -0.2        0.39 ±  5%  perf-profile.children.cycles-pp.xas_load
      0.61 ±  2%      -0.2        0.37 ±  5%  perf-profile.children.cycles-pp.security_file_permission
      0.76 ±  3%      -0.2        0.53 ±  5%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.41 ±  5%      -0.2        0.20 ± 38%  perf-profile.children.cycles-pp.xfs_iunlock
      1.03 ±  7%      -0.2        0.82 ±  8%  perf-profile.children.cycles-pp.devkmsg_emit
      1.03 ±  7%      -0.2        0.82 ±  8%  perf-profile.children.cycles-pp.devkmsg_write
      1.03 ±  7%      -0.2        0.83 ±  8%  perf-profile.children.cycles-pp.console_flush_all
      1.03 ±  7%      -0.2        0.83 ±  8%  perf-profile.children.cycles-pp.console_unlock
      1.04 ±  7%      -0.2        0.84 ±  8%  perf-profile.children.cycles-pp.vprintk_emit
      0.62 ±  3%      -0.2        0.42 ±  6%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.60 ±  2%      -0.2        0.41 ±  5%  perf-profile.children.cycles-pp.__do_softirq
      0.52 ±  3%      -0.2        0.33 ±  7%  perf-profile.children.cycles-pp.folio_alloc
      0.45 ±  2%      -0.2        0.27 ±  5%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.33 ±  6%      -0.2        0.16 ±  5%  perf-profile.children.cycles-pp.up_read
      0.38 ±  4%      -0.1        0.23 ±  8%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.45 ±  3%      -0.1        0.31 ±  6%  perf-profile.children.cycles-pp.rebalance_domains
      0.34 ±  3%      -0.1        0.20 ±  6%  perf-profile.children.cycles-pp.__fdget_pos
      0.40 ±  4%      -0.1        0.27 ±  7%  perf-profile.children.cycles-pp.__alloc_pages
      0.33 ±  3%      -0.1        0.19 ±  6%  perf-profile.children.cycles-pp.xas_descend
      0.41 ±  3%      -0.1        0.27 ±  7%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.29 ±  6%      -0.1        0.16 ±  8%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.38 ±  3%      -0.1        0.25 ±  7%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.34 ±  2%      -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.22 ±  7%      -0.1        0.10 ± 12%  perf-profile.children.cycles-pp.try_charge_memcg
      0.25 ±  3%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.xas_store
      0.31 ±  3%      -0.1        0.22 ±  6%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.20 ±  4%      -0.1        0.11 ±  7%  perf-profile.children.cycles-pp.__free_pages_ok
      0.23 ±  5%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.rmqueue
      0.22 ±  4%      -0.1        0.13 ±  8%  perf-profile.children.cycles-pp.current_time
      0.18 ±  6%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.38 ± 15%      -0.1        0.29 ± 11%  perf-profile.children.cycles-pp.ktime_get
      0.16 ±  8%      -0.1        0.08 ±  9%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.25 ±  6%      -0.1        0.17 ±  9%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.18 ±  3%      -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.18 ±  3%      -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.do_execveat_common
      0.18 ±  3%      -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.execve
      0.28 ± 21%      -0.1        0.20 ± 13%  perf-profile.children.cycles-pp.tick_irq_enter
      0.17 ±  4%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.__mmput
      0.17 ±  4%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.exit_mmap
      0.25            -0.1        0.18 ±  7%  perf-profile.children.cycles-pp.menu_select
      0.18 ±  3%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.aa_file_perm
      0.28 ± 20%      -0.1        0.21 ± 14%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.13 ±  4%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.xas_create
      0.20 ±  4%      -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.21 ±  4%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.load_balance
      0.20 ±  6%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.xas_start
      0.21 ±  4%      -0.1        0.14 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.11 ±  3%      -0.1        0.04 ± 38%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.11 ±  4%      -0.1        0.04 ± 38%  perf-profile.children.cycles-pp.xas_alloc
      0.12 ±  2%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.folio_prep_large_rmappable
      0.18 ±  4%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      0.15 ±  5%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.bprm_execve
      0.61 ±  5%      -0.1        0.55 ±  4%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.13 ±  5%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.exec_binprm
      0.13 ±  5%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.load_elf_binary
      0.13 ±  5%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.search_binary_handler
      0.08 ±  6%      -0.1        0.02 ±100%  perf-profile.children.cycles-pp.begin_new_exec
      0.14 ± 11%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.12 ±  4%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.lru_add_drain
      0.10 ±  5%      -0.1        0.04 ± 37%  perf-profile.children.cycles-pp.__xas_next
      0.12 ±  5%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.15 ±  6%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.12 ±  2%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.15 ±  4%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.find_busiest_group
      0.31 ±  5%      -0.0        0.26 ±  6%  perf-profile.children.cycles-pp.workingset_activation
      0.12 ±  4%      -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.do_exit
      0.12 ±  3%      -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.12 ±  3%      -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.do_group_exit
      0.13 ±  5%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.10 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.10 ±  4%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.10 ±  5%      -0.0        0.05 ± 38%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.15 ±  4%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
      0.35 ±  2%      -0.0        0.30 ±  3%  perf-profile.children.cycles-pp.folio_activate_fn
      0.11 ±  6%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__schedule
      0.11 ±  4%      -0.0        0.06 ± 10%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.11 ±  4%      -0.0        0.06 ± 10%  perf-profile.children.cycles-pp.exc_page_fault
      0.08 ±  4%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.unmap_region
      0.10 ±  4%      -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.exit_mm
      0.10 ±  3%      -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.handle_mm_fault
      0.15 ±  5%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.15 ±  4%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.10 ±  3%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.10 ±  6%      -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.10 ±  5%      -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.10 ±  4%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.mmap_region
      0.15 ±  6%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.08 ±  4%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.rcu_core
      0.10 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.10 ±  4%      -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.do_mmap
      0.10 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.16 ± 14%      -0.0        0.12 ± 23%  perf-profile.children.cycles-pp.vt_console_print
      0.15 ± 13%      -0.0        0.12 ± 23%  perf-profile.children.cycles-pp.con_scroll
      0.15 ± 13%      -0.0        0.11 ± 24%  perf-profile.children.cycles-pp.fbcon_redraw
      0.15 ± 13%      -0.0        0.12 ± 23%  perf-profile.children.cycles-pp.fbcon_scroll
      0.15 ± 13%      -0.0        0.12 ± 23%  perf-profile.children.cycles-pp.lf
      0.11 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.08 ± 17%      -0.0        0.05 ± 38%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.11 ±  4%      -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.perf_rotate_context
      0.09 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.schedule
      0.14 ± 13%      -0.0        0.10 ± 24%  perf-profile.children.cycles-pp.fbcon_putcs
      0.10 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.rcu_all_qs
      0.07 ±  7%      -0.0        0.03 ± 77%  perf-profile.children.cycles-pp.sched_clock
      0.10 ± 18%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__memcpy
      0.08 ±  6%      -0.0        0.04 ± 37%  perf-profile.children.cycles-pp.asm_sysvec_call_function
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.clockevents_program_event
      0.11 ± 16%      -0.0        0.08 ± 25%  perf-profile.children.cycles-pp.fast_imageblit
      0.11 ± 16%      -0.0        0.08 ± 25%  perf-profile.children.cycles-pp.drm_fbdev_generic_defio_imageblit
      0.11 ± 16%      -0.0        0.08 ± 25%  perf-profile.children.cycles-pp.sys_imageblit
      0.12 ±  5%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.find_lock_entries
      0.09 ±  4%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.native_sched_clock
      0.08 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.08 ±  5%      -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.09 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.read_tsc
      0.07 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.07 ±  8%      -0.0        0.05 ±  6%  perf-profile.children.cycles-pp.__free_one_page
      0.07 ±  9%      +0.0        0.09        perf-profile.children.cycles-pp.__mem_cgroup_uncharge
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.uncharge_batch
      0.04 ± 58%      +0.0        0.07        perf-profile.children.cycles-pp.page_counter_uncharge
      0.09 ±  7%      +0.0        0.12 ±  2%  perf-profile.children.cycles-pp.destroy_large_folio
      0.08 ±  4%      +0.0        0.13 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.free_unref_page
     89.22            +3.4       92.57        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     89.02            +3.4       92.44        perf-profile.children.cycles-pp.do_syscall_64
     86.89            +3.9       90.79        perf-profile.children.cycles-pp.read
     39.51            +4.7       44.21        perf-profile.children.cycles-pp.filemap_get_pages
     84.67            +4.7       89.40        perf-profile.children.cycles-pp.ksys_read
     84.40            +4.8       89.24        perf-profile.children.cycles-pp.vfs_read
     37.48            +5.7       43.21        perf-profile.children.cycles-pp.page_cache_ra_order
     82.04            +5.9       87.98        perf-profile.children.cycles-pp.filemap_read
     28.01            +9.2       37.19        perf-profile.children.cycles-pp.folio_mark_accessed
     27.68            +9.2       36.91 ±  2%  perf-profile.children.cycles-pp.folio_activate
     28.55           +10.4       38.96 ±  2%  perf-profile.children.cycles-pp.filemap_add_folio
     27.81           +10.7       38.48 ±  2%  perf-profile.children.cycles-pp.folio_add_lru
     54.31           +19.8       74.12 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     54.49           +19.8       74.33 ±  2%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     54.82           +19.8       74.67 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     55.58           +19.9       75.44 ±  2%  perf-profile.children.cycles-pp.folio_batch_move_lru
     12.46            -7.0        5.42 ±  7%  perf-profile.self.cycles-pp._copy_to_iter
      8.02            -4.7        3.34 ±  9%  perf-profile.self.cycles-pp.__memset
      1.14 ±  3%      -0.4        0.76 ±  6%  perf-profile.self.cycles-pp.intel_idle
      0.93 ±  3%      -0.3        0.58 ±  6%  perf-profile.self.cycles-pp.filemap_read
      0.56 ±  8%      -0.3        0.23 ±  9%  perf-profile.self.cycles-pp.down_read
      1.02            -0.3        0.70 ±  5%  perf-profile.self.cycles-pp.intel_idle_xstate
      0.49 ±  7%      -0.3        0.21 ±  8%  perf-profile.self.cycles-pp.atime_needs_update
      0.66 ±  2%      -0.2        0.42 ±  7%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.43 ± 11%      -0.2        1.18 ±  3%  perf-profile.self.cycles-pp.memcpy_toio
      0.66 ±  2%      -0.2        0.44 ±  5%  perf-profile.self.cycles-pp.filemap_get_read_batch
      0.76 ±  3%      -0.2        0.53 ±  5%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.60 ±  3%      -0.2        0.38 ±  6%  perf-profile.self.cycles-pp.write
      0.60 ±  2%      -0.2        0.38 ±  6%  perf-profile.self.cycles-pp.read
      0.53 ±  3%      -0.2        0.32 ±  6%  perf-profile.self.cycles-pp.vfs_read
      0.48            -0.2        0.31 ±  4%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.32 ±  7%      -0.2        0.16 ±  6%  perf-profile.self.cycles-pp.up_read
      0.36 ±  4%      -0.1        0.22 ±  7%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.32 ±  4%      -0.1        0.19 ±  6%  perf-profile.self.cycles-pp.__fdget_pos
      0.30 ±  7%      -0.1        0.17 ±  9%  perf-profile.self.cycles-pp.vfs_write
      0.30 ±  3%      -0.1        0.17 ±  6%  perf-profile.self.cycles-pp.xas_descend
      0.28 ±  2%      -0.1        0.16 ±  8%  perf-profile.self.cycles-pp.do_syscall_64
      0.28 ±  3%      -0.1        0.17 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.32 ±  3%      -0.1        0.22 ±  7%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.19 ±  8%      -0.1        0.09 ± 38%  perf-profile.self.cycles-pp.xfs_file_read_iter
      0.24 ±  3%      -0.1        0.14 ±  6%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.31 ±  3%      -0.1        0.22 ±  6%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.18 ±  5%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.22 ±  4%      -0.1        0.14 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.23 ±  6%      -0.1        0.16 ±  9%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.14 ±  9%      -0.1        0.07 ± 12%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.10 ±  4%      -0.1        0.02 ±100%  perf-profile.self.cycles-pp.rmqueue
      0.20 ±  3%      -0.1        0.13 ±  7%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.18 ±  3%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.xas_load
      0.09            -0.1        0.02 ±100%  perf-profile.self.cycles-pp.__xas_next
      0.17 ±  2%      -0.1        0.10 ±  6%  perf-profile.self.cycles-pp.rw_verify_area
      0.16 ±  3%      -0.1        0.10 ±  6%  perf-profile.self.cycles-pp.aa_file_perm
      0.16 ±  3%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.filemap_get_pages
      0.19 ±  6%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.xas_start
      0.18 ±  3%      -0.1        0.12 ±  5%  perf-profile.self.cycles-pp.security_file_permission
      0.17            -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.12 ±  2%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.folio_prep_large_rmappable
      0.16 ±  3%      -0.1        0.10 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.14 ± 11%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.08 ±  8%      -0.1        0.03 ± 77%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.12 ±  6%      -0.1        0.06 ± 10%  perf-profile.self.cycles-pp.__free_pages_ok
      0.08 ±  4%      -0.0        0.03 ± 77%  perf-profile.self.cycles-pp.xfs_ilock
      0.14 ±  4%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock
      0.10 ±  4%      -0.0        0.06 ± 39%  perf-profile.self.cycles-pp.xfs_iunlock
      0.12 ±  4%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.current_time
      0.11 ± 18%      -0.0        0.06 ± 17%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      0.12 ±  4%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.ksys_write
      0.15 ±  4%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.10 ±  3%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.09 ±  5%      -0.0        0.05 ± 38%  perf-profile.self.cycles-pp.xfs_file_buffered_read
      0.10 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.xas_store
      0.14 ±  3%      -0.0        0.10 ± 15%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.08 ± 17%      -0.0        0.04 ± 38%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.11 ±  4%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.ksys_read
      0.10 ± 18%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__memcpy
      0.10 ±  7%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.12 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.menu_select
      0.09 ±  4%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__cond_resched
      0.11 ± 16%      -0.0        0.08 ± 25%  perf-profile.self.cycles-pp.fast_imageblit
      0.09 ±  4%      -0.0        0.06 ±  5%  perf-profile.self.cycles-pp.read_tsc
      0.08 ±  5%      -0.0        0.06 ±  5%  perf-profile.self.cycles-pp.native_sched_clock
      0.08 ±  5%      -0.0        0.06 ±  5%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.08 ±  6%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.folio_lruvec_lock_irqsave
      0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.07 ±  4%      -0.0        0.05 ±  6%  perf-profile.self.cycles-pp.__free_one_page
      0.09 ±  8%      -0.0        0.07 ±  4%  perf-profile.self.cycles-pp.find_lock_entries
      0.09            +0.0        0.10        perf-profile.self.cycles-pp.lru_add_fn
      0.14 ±  2%      +0.0        0.16        perf-profile.self.cycles-pp.folio_batch_move_lru
      0.03 ± 77%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.page_counter_uncharge
     54.31           +19.8       74.12 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


Best Regards,
Yujie

