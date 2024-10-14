Return-Path: <linux-fsdevel+bounces-31854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEEF99C240
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0565E1F21312
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 07:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0833C156C62;
	Mon, 14 Oct 2024 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPJ0bX/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0229915689A;
	Mon, 14 Oct 2024 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892561; cv=fail; b=QpRShS2e9A//KG5LrdjGJpNLwk1ATmUYaO9Ev5dNGmdkGor/OdGTwjp+ljNLVkPqDCMaf8cNykyWEW299xsM107KO5Xs4JV5Q2hyv4aBg6fA3RwnSeChG3C5bzSevLIQh/SzKah+AQH56eYnT5ipn7VhaMcQdeqHSlFnsDQHALA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892561; c=relaxed/simple;
	bh=D8MyCkBaEHQh5kXQuNy78xjsNHD8XWgIkKWrdJcexxI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Ecyjiag1jennBiedUWjsbJN8F19UKXUIAsNh5TmaFC9xzc2lRl6LkueL1+5vX+ySJRuVTkqylR0BbHWD36m9FRp0tx8vGgIPqGmyEl+9AuD8Dkq+U7PrlMicBK9mikrqupA+9r1Z9E9XS4e2xiLgvedPxz9vHCXrPhaZAxlEn2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LPJ0bX/J; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728892557; x=1760428557;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=D8MyCkBaEHQh5kXQuNy78xjsNHD8XWgIkKWrdJcexxI=;
  b=LPJ0bX/J/VDNJnmRMXdm0FD30mxXPxFYVXuZBIu1/feNvRYERijyu3kh
   88GFob+lMhIiqruu4nwabQhmKanyDkQMiKF+WqXL7ePJvYxLEBqZS3cyD
   a4MyDVXEWzpITsAz43NEGqbQr+bSDw/x7EDB+9EOfhwmAUhsFag2fwM6N
   aPz+Jf2rb2dugFa4reWk05KEpCcJBhAlPQXzXriouQn2mtuzaOUFritNq
   6QRKLk4JjlvlWPBfBFI4EbVRWj/3Z9lN7Aa6l27U8ntZLUgyFZufYJ/4n
   tGm8IHXUZjOwnVB0MmfhR44IFBT4w87PFykDH7ZWLlV6tEkU5h9/EZiHP
   g==;
X-CSE-ConnectionGUID: iVmXQUtjQu2HSAttLLiAwA==
X-CSE-MsgGUID: 1twvqsN2QQ2NAhrpIGB+WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="38809132"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="38809132"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 00:55:49 -0700
X-CSE-ConnectionGUID: bzfxX+MZRP6bfG1fhKUfiA==
X-CSE-MsgGUID: XGtfyXIxTouZ5d2aYnGHKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="81484321"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 00:55:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 00:55:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 00:55:41 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 00:55:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npq52KtWNwI+UcNdQpA8bouI0QgR4hbt83knCjG476YMMgnwG7ddUgT/gwwf3Hwwgw6pA0dTRO3id+dQ4ZhuVLa1AfMz6plOIt6GYP/zmwCoX9o7dQ1tV47hNyl9+R1y3KomIOEb/6NU4n+/MYOL3uY2hERoTW0jFn8RiMyQwuks6DpjguaFQtoy9wAJIbyRh53G3dc5Iqrp2AatfdsFXgqfzhKGmcQ4SWszAVVwFQpujeedeEanh2DOvk65U0i0/Sp+c20CPEDFypmsCWWy1zw1Jfxb+DWMp4UTclU5fGXN8HiwQthXt4Xy3nQU7vkwwZgbhrsdBRCQqL74shWAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGyTXXw9CmIAvcWEAMi1zgbcyv2xJ/f4+Ybwbx5POJk=;
 b=FQ8xiribBmfPVY0bKafdi4JL7x5ex4BzDEEeE59KLDglRDp9hhu/r++2h6Vp6L4CDzkGNqaeZTc3FVZ/D3M0VyvOH/z3yVBFiUWdnoL5fogy2gUJcTX9w9oaEBaP7MnOVvhzBdBLQoEnr1gaL0go3SzB0rUhW2VHdawiqPjc4a3MbIYGyDDJipD3P03hXPGq46Rpv+dGjmuhvSXVh75ebf62PslUf2MgrDmotMPHdhQwo5CFGTBB6lMp2oCn2ZU5EJx9COqpepcetu+eKp/HoYQ2SAYv9iMIH7KPYuKfpYYaiCZMJ2P78GxwxI/hfcr/nrbx3CBAma8nerN6HYVB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4637.namprd11.prod.outlook.com (2603:10b6:806:97::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 07:55:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 07:55:36 +0000
Date: Mon, 14 Oct 2024 15:55:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Brian Foster <bfoster@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
	<djwong@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	<linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [iomap]  c5c810b94c:  stress-ng.metamix.ops_per_sec
 -98.4% regression
Message-ID: <202410141536.1167190b-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0033.apcprd04.prod.outlook.com
 (2603:1096:820:e::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4aaee0-ffbe-4f2c-989e-08dcec25969c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?UT3C+tuojHugxqa1ldDMcdSKxp6uWRPsz9zo8wijYBTrw2XhtjMOfZYJhq?=
 =?iso-8859-1?Q?PNBLm4pbQYr5UAQPVnmi5zBBQ8vzv4+74qzRogv1U/osq+oheZY+09Govw?=
 =?iso-8859-1?Q?lMSH5FYfFaxB+zwXM0FTGIxNL03D9ElrNT7QnF1AGZLlxlGxBsEeGJmTO7?=
 =?iso-8859-1?Q?8EXtbVTyoO6vbCrkVmeQei7WgS25m2toddsf+HUJWUWL+hAgYHgMg22Ahk?=
 =?iso-8859-1?Q?Y2hPmgQfoewY0E1aVQ6biNEldfkkzRcLZHNis8trZ1baqkadddjkKLJ+WW?=
 =?iso-8859-1?Q?A54Oy8mrS4pMJvHpCY6ySUnMKpEUW8k+mUu6UCgW3Lql120DB4F+apjhtm?=
 =?iso-8859-1?Q?Yk8lcZXFnA2nrV3JzNZeQs5WxkXS7EA/y9fEqjYl6CwBF5lu96uh/ieVdx?=
 =?iso-8859-1?Q?SG4HEY0wKN0rv7nXdw9s2kUqa75Is7OtOgQrXA5/n0uMOe1RvSNOVFRode?=
 =?iso-8859-1?Q?V3vyfzLVi4K3ZIa7Hj4JwVg35bp8HXPnW9nuNqENJ7OGj02ngd/yttoWIP?=
 =?iso-8859-1?Q?cFU/7sN9vXEjs1tlUtVtd+9UTjrY7LiJNyOABaCib9N+kI9mEjxoH8Jro4?=
 =?iso-8859-1?Q?3dIFW1xbNlz2+1XVGBr5GuEYCgm+0yBCIA3FJORfzt+dQZqIrveYfi21Lc?=
 =?iso-8859-1?Q?/Ojocvp8sC38qQLbp5K+ukWpfc4JFAhiEVpFh2uER5hIa284/G56v9OgW4?=
 =?iso-8859-1?Q?sM7Yv1pA5ad5T2ts/Gh0Z337br5ebbylwqwnWWE/0730UxeyWbHJOfe/4J?=
 =?iso-8859-1?Q?5gQ2lgbpIdKNi1NLVc7fcekis3GQXHYUEQhbhI2YSDet3rIFnOeaD8fG0a?=
 =?iso-8859-1?Q?azS6hzRSDZkRxQ3NoqPFETXXH7RKdPB4HIeZs85lAMo1vx3mQYGeyKn7ko?=
 =?iso-8859-1?Q?Ow62qMLGVj9NpdikldNjuPKy50LRDLVWVoNGBIRLlK3RGhWwySrBi8kio9?=
 =?iso-8859-1?Q?cV1cDXpH7X8c3kGH/SkblidxbvQCkIukuYgcWp02LoHN82Z0h1EzIZDcPT?=
 =?iso-8859-1?Q?atcD2gQiukW9IaeTzzx/rsN6+nSQXS+Fok5hMf/rMN2wpm3aUulPruxOpL?=
 =?iso-8859-1?Q?zIaomOG3eXM1i1lchJMuTYZvFLxD/tJJN+IN7BTVoeLuKAQ1zAcgnMwo9T?=
 =?iso-8859-1?Q?eiZy/2j0LLl+POnvYBLn1j4T4TbhZa2MAhuWUB8L01M0G4fK+zYfJ373D9?=
 =?iso-8859-1?Q?Ydg/Rc7fzzhCKX1lqorokH26bNRjFK+cOerxVETbqhGSWeITj5Jnf3ooYI?=
 =?iso-8859-1?Q?PScA7+N+9+dCiW6N3CA1mfxIhYgsE7vtQ7g7VSgUc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?EXpDEo1DybHdGahJK9t5oucKZBFAP9KFcXP+fkwVFUqh5yTvJoubbTfosO?=
 =?iso-8859-1?Q?nxtpvAMhLKGQLwXcFK0F+/PXc9Q8n760tdM7VA3AMNd02W7JMuy1R7ch4M?=
 =?iso-8859-1?Q?wtckF1cshkGgj4PXt4kiAamw7Dg0DniBHiWvSJAm3WgWu4BvwWW/yept57?=
 =?iso-8859-1?Q?b7mHZie81M/wS6WsF2V2X5Xgqe+rL1Av9SSXWSyyWjbSjnLps6x/qS66Dx?=
 =?iso-8859-1?Q?OiqhW+ymSmHYxqYVE8mKi4B4UMvC26SccdkQ9vzLkXHVsEgxkRKaQz6Ij6?=
 =?iso-8859-1?Q?80OGs11voda2sifDuhvvOD9TyG4jJ7s4K8muun91LHGX9zSmlrG3GzsLg4?=
 =?iso-8859-1?Q?Rxogvs7gqwBEo67I6BLbDIEyBAMrQpihyRqikRvO0QC8BIiAX58HynYb9E?=
 =?iso-8859-1?Q?+0m5cIh5WzqD2ycOkcshdF/E8Zl88YFNRzDDbDCVIIeT5dI01tcDLNYLkI?=
 =?iso-8859-1?Q?L5xFsIfUU+T4jPbcasUmhhm313asdkKgVopLahJNqAejNQbV0pF/q6pu62?=
 =?iso-8859-1?Q?RX78IYgoOKG7PSmqOHul5pBlVehF/fs6Amjv3qq4kL9H8eA/MXI2gVgPGE?=
 =?iso-8859-1?Q?DDM23q7QamGXstVQEw6d515l9mnUFdh0gOaB3Xj7cLeb9+PsNAfl+KpFd/?=
 =?iso-8859-1?Q?h81BRLSN0TyiR60VixO4q2BrPXnfOa2hBEAzdFpXqfLG14Wz48JZFKBXZS?=
 =?iso-8859-1?Q?9w5kfLVZS4CvNpW86ewkS7vlloZl+6+a7k184owdX7XOioiU5sqPAz/OpA?=
 =?iso-8859-1?Q?zBlg+bXOyEDTmETfoc9FEjsyTz0xWudlkYkhhAnfMDFWghYhp8qpdJ5JDX?=
 =?iso-8859-1?Q?wYLw30MpPRkk8HuzBcVcfW9JqCUETC+XoLqakaKVyzb0Lt2VeLoorjj+ro?=
 =?iso-8859-1?Q?1jgBCAukUBRIbpx1vk7vTwRjI5U0PfJvIQSIs3Bh5spgM/VNUehd7BpB7V?=
 =?iso-8859-1?Q?B5iWz90xFWZpppiGtK01D7IjjXbU2oxdStTdIaexehsWvFv5Z9qtdcWkWl?=
 =?iso-8859-1?Q?vLmTe5v1IqD46iLU8UwrOj71AOT9PvPuVmd2ksssUZi1L7eV9PibPKU00w?=
 =?iso-8859-1?Q?kzK1pxs+HqBg1dhyWTz9qjt/2cw4VjEeoZRYGKRQly56Et7yVScFaj/iIw?=
 =?iso-8859-1?Q?OqeuPBmVC8JMVUNEh4/Hr5KZPZeGD1oJZeW0P+ahfkZNC3COgYmAEBwzsz?=
 =?iso-8859-1?Q?zdS8a6RXSJ59R791qV/4gVcXKcKfTayMNYOsBOf4ARp7aD/6W83WkJZEZK?=
 =?iso-8859-1?Q?MIbhYrNkk5wt1q5oI56mMb+fJR2Xu6rgngSYhxqk02/kCnLwZgBGHwVCi7?=
 =?iso-8859-1?Q?fwCED6PWwNA8tjF6UaXibIP3IGDqjvcKMrwiOFweBcJlNZ6zfzjf358h4G?=
 =?iso-8859-1?Q?ZKn3BmQYVL7clQ+NNy0EB59kia/UwqLEjO0kzM6Y1Xfa/+yQiUfP0cADcv?=
 =?iso-8859-1?Q?G3U8ZIGhA8oKhcJMP3fjvW8k0G/Fhm4tHmuSoA+VW7XxOfm1/jtousC2g9?=
 =?iso-8859-1?Q?SR41tJ1ikq7OqyGcNdSj0KyyjYtoGn4utKGGjPKiw85tNOXm/MiLR+dIUU?=
 =?iso-8859-1?Q?vcAPv37Yehx3zcKifaX2N2iziofHHp+6bpTgKL6Qd1O5sidEKrKQIoo+eC?=
 =?iso-8859-1?Q?U9lLKQYlsYuFKJy048NSAKFyunxbOXV/9uYV9qiiUGJmpnxdPNVeOXcg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4aaee0-ffbe-4f2c-989e-08dcec25969c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 07:55:36.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOO/c7kEqEekXKj3JhPjYFmZJ+DZO9McDxZv3SI6o0d0OJPUqo1E/mwyBPWeNmasCIIoAKmCzA5nhwhxqj58jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4637
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -98.4% regression of stress-ng.metamix.ops_per_sec on:


commit: c5c810b94cfd818fc2f58c96feee58a9e5ead96d ("iomap: fix handling of dirty folios over unwritten extents")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: xfs
	test: metamix
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410141536.1167190b-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241014/202410141536.1167190b-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/xfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/metamix/stress-ng/60s

commit: 
  6f634eb080 ("filemap: fix htmldoc warning for mapping_align_index()")
  c5c810b94c ("iomap: fix handling of dirty folios over unwritten extents")

6f634eb080161baa c5c810b94cfd818fc2f58c96fee 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 5.762e+09 ±  6%   +1784.6%  1.086e+11 ±  3%  cpuidle..time
    537216 ±  8%    +846.9%    5087100 ±  3%  cpuidle..usage
      5.83 ± 13%     -72.0%       1.63 ±  3%  iostat.cpu.idle
     93.48            +5.1%      98.28        iostat.cpu.iowait
    134.32 ±  4%   +1197.6%       1742 ±  3%  uptime.boot
      2789 ±  3%     +54.0%       4295 ±  4%  uptime.idle
     47.17 ±144%     -81.6%       8.67 ± 24%  perf-c2c.DRAM.local
     89.00 ± 77%     -58.4%      37.00 ±  9%  perf-c2c.HITM.local
     42.33 ± 86%     -63.0%      15.67 ± 26%  perf-c2c.HITM.remote
    609419 ± 10%    +144.5%    1489941 ± 18%  numa-numastat.node0.local_node
    628123 ± 10%    +142.2%    1521154 ± 17%  numa-numastat.node0.numa_hit
    537937 ±  4%    +288.1%    2087519 ± 10%  numa-numastat.node1.local_node
    585710 ±  4%    +262.4%    2122854 ± 10%  numa-numastat.node1.numa_hit
     33057 ±  5%     -94.2%       1926 ±  2%  vmstat.io.bo
      1.72 ±  6%     -37.5%       1.08        vmstat.procs.r
      5454 ±  6%     -45.2%       2990        vmstat.system.cs
      5999 ±  4%     -53.5%       2790        vmstat.system.in
      3.79 ± 19%      -2.3        1.52 ±  3%  mpstat.cpu.all.idle%
      0.02 ± 23%      -0.0        0.01 ±  3%  mpstat.cpu.all.irq%
      0.01 ±  4%      -0.0        0.00        mpstat.cpu.all.soft%
      0.25 ±  6%      -0.2        0.05 ±  4%  mpstat.cpu.all.sys%
      0.40 ±  5%      -0.4        0.03 ±  7%  mpstat.cpu.all.usr%
      6.44 ±  5%     -13.8%       5.55 ±  3%  mpstat.max_utilization_pct
      1991 ± 14%     -68.8%     621.17 ±  9%  stress-ng.metamix.ops
     23.12 ± 10%     -98.4%       0.37 ±  7%  stress-ng.metamix.ops_per_sec
     87.77 ±  6%   +1831.7%       1695 ±  3%  stress-ng.time.elapsed_time
     87.77 ±  6%   +1831.7%       1695 ±  3%  stress-ng.time.elapsed_time.max
    120134 ±  2%      -5.1%     114001        stress-ng.time.minor_page_faults
      5.67 ±  8%     -82.4%       1.00        stress-ng.time.percent_of_cpu_this_job_got
      4.90 ±  7%    +331.2%      21.13 ±  4%  stress-ng.time.system_time
     63630 ±  9%   +1332.9%     911761 ±  3%  stress-ng.time.voluntary_context_switches
     25272 ±  6%    +100.3%      50631        meminfo.Active
     20787 ± 10%     +96.7%      40898 ±  2%  meminfo.Active(anon)
      4485 ± 15%    +117.0%       9733        meminfo.Active(file)
    207516 ±  6%    +216.6%     656984 ± 10%  meminfo.AnonHugePages
    377749 ±  4%     +31.5%     496804        meminfo.Dirty
   1808866           -20.6%    1436964        meminfo.Inactive
    902066           -43.7%     508085        meminfo.Inactive(file)
   6425133           -10.6%    5746563        meminfo.Memused
     11.47        +17676.6%       2038        meminfo.Mlocked
    102534           +22.7%     125834        meminfo.Shmem
    119495           -95.0%       5925 ±  3%  meminfo.Writeback
   7239789           -14.4%    6193951        meminfo.max_used_kB
      2230 ± 16%     +72.8%       3853 ±  5%  numa-meminfo.node0.Active(file)
     84262 ± 27%    +532.6%     533075 ± 25%  numa-meminfo.node0.AnonHugePages
    401080 ± 65%     +81.0%     726026 ± 10%  numa-meminfo.node0.AnonPages.max
    450689 ±  3%     -59.7%     181817 ±  4%  numa-meminfo.node0.Inactive(file)
     15857 ±  4%     -12.5%      13880 ±  4%  numa-meminfo.node0.KernelStack
      5.73 ±100%  +14883.5%     858.83 ± 96%  numa-meminfo.node0.Mlocked
     59744 ±  3%     -96.6%       2047 ±  4%  numa-meminfo.node0.Writeback
     16267 ± 11%    +121.2%      35987 ± 16%  numa-meminfo.node1.Active
     14010 ± 13%    +114.9%      30108 ± 20%  numa-meminfo.node1.Active(anon)
      2257 ± 15%    +160.4%       5879 ±  4%  numa-meminfo.node1.Active(file)
    188486 ±  7%     +69.0%     318533 ±  3%  numa-meminfo.node1.Dirty
    956395 ± 30%     -43.4%     541330 ± 20%  numa-meminfo.node1.Inactive
    452002 ±  5%     -27.8%     326319 ±  3%  numa-meminfo.node1.Inactive(file)
    150109 ± 13%     +16.7%     175200 ±  5%  numa-meminfo.node1.Slab
     59749 ±  4%     -93.5%       3891 ±  5%  numa-meminfo.node1.Writeback
    556.82 ± 16%     +73.0%     963.40 ±  5%  numa-vmstat.node0.nr_active_file
     41.21 ± 27%    +531.7%     260.29 ± 25%  numa-vmstat.node0.nr_anon_transparent_hugepages
    379768 ± 11%     -23.8%     289236 ±  3%  numa-vmstat.node0.nr_dirtied
    112900 ±  2%     -59.7%      45451 ±  4%  numa-vmstat.node0.nr_inactive_file
     15877 ±  4%     -12.6%      13883 ±  3%  numa-vmstat.node0.nr_kernel_stack
      1.44 ±100%  +14824.7%     214.67 ± 96%  numa-vmstat.node0.nr_mlock
     14977 ±  3%     -96.6%     512.83 ±  4%  numa-vmstat.node0.nr_writeback
    379768 ± 11%     -25.6%     282645 ±  3%  numa-vmstat.node0.nr_written
    556.84 ± 16%     +73.0%     963.40 ±  5%  numa-vmstat.node0.nr_zone_active_file
    112900 ±  2%     -59.7%      45451 ±  4%  numa-vmstat.node0.nr_zone_inactive_file
     62482 ±  3%     -27.8%      45088 ±  4%  numa-vmstat.node0.nr_zone_write_pending
    625814 ± 10%    +143.0%    1520756 ± 17%  numa-vmstat.node0.numa_hit
    607109 ± 10%    +145.4%    1489543 ± 18%  numa-vmstat.node0.numa_local
      3496 ± 13%    +115.3%       7527 ± 20%  numa-vmstat.node1.nr_active_anon
    563.82 ± 16%    +160.7%       1469 ±  4%  numa-vmstat.node1.nr_active_file
    380179 ±  9%     +38.2%     525240 ±  5%  numa-vmstat.node1.nr_dirtied
     47231 ±  7%     +68.6%      79622 ±  3%  numa-vmstat.node1.nr_dirty
    113239 ±  5%     -28.0%      81571 ±  3%  numa-vmstat.node1.nr_inactive_file
     14977 ±  4%     -93.5%     974.17 ±  5%  numa-vmstat.node1.nr_writeback
    380179 ±  9%     +35.0%     513207 ±  5%  numa-vmstat.node1.nr_written
      3496 ± 13%    +115.3%       7527 ± 20%  numa-vmstat.node1.nr_zone_active_anon
    563.82 ± 16%    +160.7%       1469 ±  4%  numa-vmstat.node1.nr_zone_active_file
    113239 ±  5%     -28.0%      81571 ±  3%  numa-vmstat.node1.nr_zone_inactive_file
     62209 ±  6%     +29.6%      80597 ±  3%  numa-vmstat.node1.nr_zone_write_pending
    583795 ±  4%    +263.5%    2121826 ± 10%  numa-vmstat.node1.numa_hit
    535988 ±  4%    +289.3%    2086491 ± 10%  numa-vmstat.node1.numa_local
      5190 ± 10%     +97.0%      10224 ±  2%  proc-vmstat.nr_active_anon
      1122 ± 14%    +116.7%       2433        proc-vmstat.nr_active_file
    208668            +2.2%     213362        proc-vmstat.nr_anon_pages
    101.32 ±  6%    +216.6%     320.79 ± 10%  proc-vmstat.nr_anon_transparent_hugepages
     94628 ±  4%     +31.3%     124208        proc-vmstat.nr_dirty
   1051112            -8.7%     959304        proc-vmstat.nr_file_pages
    226820            +2.4%     232205        proc-vmstat.nr_inactive_anon
    225925           -43.8%     127025        proc-vmstat.nr_inactive_file
     29400            -6.6%      27458        proc-vmstat.nr_kernel_stack
      2.88        +17612.4%     509.76        proc-vmstat.nr_mlock
     22780            -6.0%      21412 ±  3%  proc-vmstat.nr_page_table_pages
     25696 ±  2%     +22.4%      31461        proc-vmstat.nr_shmem
     26966            +2.2%      27573        proc-vmstat.nr_slab_reclaimable
     63926            +2.0%      65209        proc-vmstat.nr_slab_unreclaimable
     29903           -95.0%       1484 ±  3%  proc-vmstat.nr_writeback
      5190 ± 10%     +97.0%      10224 ±  2%  proc-vmstat.nr_zone_active_anon
      1122 ± 14%    +116.7%       2433        proc-vmstat.nr_zone_active_file
    226820            +2.4%     232205        proc-vmstat.nr_zone_inactive_anon
    225925           -43.8%     127025        proc-vmstat.nr_zone_inactive_file
   1215783 ±  6%    +199.9%    3646420 ±  3%  proc-vmstat.numa_hit
   1149305 ±  7%    +211.5%    3579877 ±  3%  proc-vmstat.numa_local
     89633 ±  7%    +349.7%     403114 ±  3%  proc-vmstat.pgactivate
   1312602 ±  6%    +200.5%    3944776 ±  3%  proc-vmstat.pgalloc_normal
    415149 ±  3%    +897.4%    4140633 ±  3%  proc-vmstat.pgfault
   1306213 ±  6%    +200.3%    3923139 ±  3%  proc-vmstat.pgfree
     16256 ±  3%   +1057.0%     188090 ±  3%  proc-vmstat.pgreuse
      1.82 ±  4%      -9.6%       1.65        perf-stat.i.MPKI
  3.76e+08 ±  6%     -89.1%   40978627 ±  4%  perf-stat.i.branch-instructions
      2.30 ±  3%      -0.6        1.66        perf-stat.i.branch-miss-rate%
  17129191 ±  7%     -93.0%    1196180 ±  7%  perf-stat.i.branch-misses
     16.84 ±  3%      -6.5       10.36        perf-stat.i.cache-miss-rate%
   1341312 ±  4%     -81.2%     251609        perf-stat.i.cache-misses
   7592299 ±  3%     -73.3%    2030865        perf-stat.i.cache-references
      5488 ±  6%     -45.6%       2986        perf-stat.i.context-switches
      1.35 ±  4%      +8.7%       1.47        perf-stat.i.cpi
 1.867e+09 ±  5%     -86.0%  2.607e+08 ±  6%  perf-stat.i.cpu-cycles
    199.44 ±  2%     -59.4%      80.94        perf-stat.i.cpu-migrations
      1655 ± 13%     -41.4%     969.67        perf-stat.i.cycles-between-cache-misses
 1.841e+09 ±  6%     -89.2%  1.994e+08 ±  4%  perf-stat.i.instructions
      0.87           -18.5%       0.71        perf-stat.i.ipc
      0.57 ± 40%     -97.6%       0.01 ± 43%  perf-stat.i.major-faults
      0.01 ±141%  +30993.6%       2.48 ±  5%  perf-stat.i.metric.K/sec
      3665 ±  3%     -36.0%       2345        perf-stat.i.minor-faults
      3666 ±  3%     -36.0%       2345        perf-stat.i.page-faults
      0.73 ±  5%     +72.7%       1.26 ±  4%  perf-stat.overall.MPKI
      4.55            -1.6        2.92 ±  3%  perf-stat.overall.branch-miss-rate%
     17.66 ±  2%      -5.3       12.39        perf-stat.overall.cache-miss-rate%
      1.02 ±  5%     +28.1%       1.31 ±  3%  perf-stat.overall.cpi
      1397 ±  5%     -25.8%       1036 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.98 ±  5%     -22.1%       0.77 ±  3%  perf-stat.overall.ipc
 3.728e+08 ±  6%     -89.0%   41014226 ±  4%  perf-stat.ps.branch-instructions
  16957001 ±  7%     -92.9%    1198002 ±  7%  perf-stat.ps.branch-misses
   1332233 ±  4%     -81.1%     251650        perf-stat.ps.cache-misses
   7543069 ±  3%     -73.1%    2030809        perf-stat.ps.cache-references
      5443 ±  6%     -45.2%       2985        perf-stat.ps.context-switches
     63285            +1.1%      63962        perf-stat.ps.cpu-clock
 1.859e+09 ±  5%     -86.0%  2.611e+08 ±  6%  perf-stat.ps.cpu-cycles
    198.47 ±  3%     -59.2%      80.91        perf-stat.ps.cpu-migrations
 1.826e+09 ±  6%     -89.1%  1.996e+08 ±  4%  perf-stat.ps.instructions
      0.58 ± 41%     -97.6%       0.01 ± 43%  perf-stat.ps.major-faults
      3640 ±  3%     -35.6%       2344        perf-stat.ps.minor-faults
      3640 ±  3%     -35.6%       2344        perf-stat.ps.page-faults
     63285            +1.1%      63962        perf-stat.ps.task-clock
 1.637e+11 ±  5%    +106.8%  3.387e+11 ±  4%  perf-stat.total.instructions
      0.01 ± 31%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.iomap_writepage_map_blocks.iomap_writepage_map
      0.01 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      0.00 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
      0.00 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fdatasync
      0.01 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.xlog_wait_on_iclog.xfs_file_fsync.__x64_sys_fdatasync.do_syscall_64
      0.00 ± 12%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fdatasync
      0.01 ±  8%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
      0.02 ±135%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.iomap_writepage_map_blocks.iomap_writepage_map
      0.14 ± 79%     -88.5%       0.02 ±103%  perf-sched.sch_delay.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      0.02 ± 77%     -67.9%       0.01 ±  5%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.02 ± 38%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      0.01 ± 44%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
      0.00 ± 26%    -100.0%       0.00        perf-sched.sch_delay.max.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fdatasync
      0.01 ±103%    -100.0%       0.00        perf-sched.sch_delay.max.ms.xlog_wait_on_iclog.xfs_file_fsync.__x64_sys_fdatasync.do_syscall_64
      0.00 ± 11%    -100.0%       0.00        perf-sched.sch_delay.max.ms.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fdatasync
      0.01 ± 11%    -100.0%       0.00        perf-sched.sch_delay.max.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
      8119 ±  9%     -50.9%       3990 ± 15%  perf-sched.total_wait_and_delay.count.ms
    765.01 ± 48%    -100.0%       0.01        perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      8.46 ±  6%     +27.6%      10.79 ± 16%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     50.66          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
    134.86 ± 13%    +158.8%     348.98 ± 18%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     65.33 ± 70%    +353.1%     296.00 ± 64%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      1366 ± 18%     -78.6%     293.00 ± 64%  perf-sched.wait_and_delay.count.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
     97.17          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.xfsaild.kthread.ret_from_fork
      3007 ± 18%     -77.6%     674.17 ± 29%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2858 ± 50%    -100.0%       0.04 ± 72%  perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    103.17 ± 10%     +73.5%     179.00 ± 24%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     59.66 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
    765.00 ± 48%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     93.17 ± 32%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      8.45 ±  6%     +27.6%      10.78 ± 16%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     50.65          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
    134.64 ± 13%    +158.9%     348.54 ± 18%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fdatasync
    202.39 ± 62%    -100.0%       0.00        perf-sched.wait_time.avg.ms.xlog_wait_on_iclog.xfs_file_fsync.__x64_sys_fdatasync.do_syscall_64
    248.16 ± 50%    -100.0%       0.00        perf-sched.wait_time.avg.ms.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fdatasync
    219.73 ± 46%    -100.0%       0.00        perf-sched.wait_time.avg.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
      2858 ± 50%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    468.55 ± 29%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
    103.16 ± 10%     +73.5%     179.00 ± 24%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     59.65 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
      0.02 ± 25%    -100.0%       0.00        perf-sched.wait_time.max.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fdatasync
    348.84 ± 58%    -100.0%       0.00        perf-sched.wait_time.max.ms.xlog_wait_on_iclog.xfs_file_fsync.__x64_sys_fdatasync.do_syscall_64
    486.25 ± 23%    -100.0%       0.00        perf-sched.wait_time.max.ms.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.__x64_sys_fdatasync
    473.19 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
      7346 ±  4%     +23.0%       9033 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.avg
    848.55 ±  8%    +123.3%       1894 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.14 ± 14%     -71.2%       0.04 ±  2%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.32 ±  9%     -41.3%       0.19 ±  2%  sched_debug.cfs_rq:/.h_nr_running.stddev
    139317 ±191%     -88.9%      15437 ±  4%  sched_debug.cfs_rq:/.load.avg
   8499863 ±201%     -92.8%     613636 ±  4%  sched_debug.cfs_rq:/.load.max
    247.33 ± 32%     -85.6%      35.54 ± 46%  sched_debug.cfs_rq:/.load_avg.avg
    632.63 ± 71%     -74.1%     163.67 ± 68%  sched_debug.cfs_rq:/.load_avg.stddev
      7346 ±  4%     +23.0%       9033 ±  7%  sched_debug.cfs_rq:/.min_vruntime.avg
    848.55 ±  8%    +123.3%       1894 ± 11%  sched_debug.cfs_rq:/.min_vruntime.min
      0.14 ± 14%     -71.2%       0.04 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
      0.32 ±  9%     -41.3%       0.19 ±  2%  sched_debug.cfs_rq:/.nr_running.stddev
     62.04 ± 22%     -89.5%       6.51 ± 42%  sched_debug.cfs_rq:/.removed.load_avg.avg
    597.33 ± 31%     -63.0%     220.77 ± 53%  sched_debug.cfs_rq:/.removed.load_avg.max
    171.33 ±  9%     -80.1%      34.06 ± 47%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     18.96 ± 25%     -85.8%       2.70 ± 45%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    308.25 ± 31%     -64.0%     111.09 ± 54%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     60.15 ± 17%     -74.0%      15.67 ± 51%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     18.96 ± 25%     -85.8%       2.70 ± 45%  sched_debug.cfs_rq:/.removed.util_avg.avg
    308.25 ± 31%     -64.0%     111.09 ± 54%  sched_debug.cfs_rq:/.removed.util_avg.max
     60.15 ± 17%     -74.0%      15.67 ± 51%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    237.66 ±  5%     -85.8%      33.72 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
      1104 ± 12%     -45.6%     600.94 ±  2%  sched_debug.cfs_rq:/.runnable_avg.max
    226.39 ±  5%     -57.8%      95.63 ±  2%  sched_debug.cfs_rq:/.runnable_avg.stddev
    236.68 ±  5%     -85.9%      33.42 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      1103 ± 12%     -46.3%     591.99        sched_debug.cfs_rq:/.util_avg.max
    226.37 ±  5%     -58.2%      94.62 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
     18.18 ± 24%     -83.7%       2.96 ± 17%  sched_debug.cfs_rq:/.util_est.avg
    338.67 ± 13%     -67.8%     109.03 ± 15%  sched_debug.cfs_rq:/.util_est.max
     67.93 ± 17%     -76.8%      15.79 ± 14%  sched_debug.cfs_rq:/.util_est.stddev
    803668 ±  2%     +18.9%     955672        sched_debug.cpu.avg_idle.avg
    198446 ±  5%     -41.6%     115938 ± 11%  sched_debug.cpu.avg_idle.stddev
     74790         +1064.4%     870887 ±  3%  sched_debug.cpu.clock.avg
     74795         +1064.4%     870893 ±  3%  sched_debug.cpu.clock.max
     74786         +1064.5%     870879 ±  3%  sched_debug.cpu.clock.min
      2.48 ±  4%     +26.3%       3.14 ±  8%  sched_debug.cpu.clock.stddev
     74525         +1068.1%     870538 ±  3%  sched_debug.cpu.clock_task.avg
     74776         +1064.6%     870850 ±  3%  sched_debug.cpu.clock_task.max
     66679         +1193.0%     862189 ±  3%  sched_debug.cpu.clock_task.min
    339.14 ± 15%     +27.9%     433.69 ±  4%  sched_debug.cpu.curr->pid.avg
      4069          +498.1%      24338 ±  3%  sched_debug.cpu.curr->pid.max
    895.15 ±  7%    +243.7%       3076 ±  3%  sched_debug.cpu.curr->pid.stddev
      0.14 ± 15%     -74.6%       0.04 ±  8%  sched_debug.cpu.nr_running.avg
      0.31 ± 11%     -44.7%       0.17 ±  6%  sched_debug.cpu.nr_running.stddev
      4679 ±  4%    +794.9%      41879 ±  4%  sched_debug.cpu.nr_switches.avg
     27295 ± 11%    +571.5%     183299 ±  4%  sched_debug.cpu.nr_switches.max
      1238 ± 20%    +985.0%      13436 ± 12%  sched_debug.cpu.nr_switches.min
      4550 ± 12%    +581.7%      31022 ±  7%  sched_debug.cpu.nr_switches.stddev
      8.07           +60.9%      12.99 ±  2%  sched_debug.cpu.nr_uninterruptible.avg
     35.50 ± 10%     +49.5%      53.06 ± 14%  sched_debug.cpu.nr_uninterruptible.max
     10.63 ±  7%     +33.5%      14.19 ± 12%  sched_debug.cpu.nr_uninterruptible.stddev
     74787         +1064.5%     870884 ±  3%  sched_debug.cpu_clk
     73624         +1081.3%     869721 ±  3%  sched_debug.ktime
     75383         +1056.2%     871587 ±  3%  sched_debug.sched_clk
     12.22 ± 39%     -12.2        0.00        perf-profile.calltrace.cycles-pp.fdatasync.stress_metamix
     12.15 ± 39%     -12.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fdatasync.stress_metamix
     12.15 ± 39%     -12.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fdatasync.stress_metamix
     12.02 ± 40%     -12.0        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_fdatasync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fdatasync.stress_metamix
     12.02 ± 40%     -12.0        0.00        perf-profile.calltrace.cycles-pp.xfs_file_fsync.__x64_sys_fdatasync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fdatasync
      9.67 ± 50%      -9.2        0.44 ±112%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
      8.34 ± 50%      -7.9        0.41 ±108%  perf-profile.calltrace.cycles-pp.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write
      7.12 ± 30%      -7.1        0.00        perf-profile.calltrace.cycles-pp.file_write_and_wait_range.xfs_file_fsync.__x64_sys_fdatasync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.81 ± 32%      -6.8        0.00        perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.__x64_sys_fdatasync.do_syscall_64
      6.81 ± 32%      -6.8        0.00        perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.__x64_sys_fdatasync
      6.80 ± 32%      -6.8        0.00        perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync
      6.80 ± 32%      -6.8        0.00        perf-profile.calltrace.cycles-pp.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range
      6.44 ± 49%      -6.3        0.12 ±223%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
      5.25 ± 45%      -5.2        0.00        perf-profile.calltrace.cycles-pp.iomap_writepage_map.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc
      4.70 ± 47%      -4.7        0.00        perf-profile.calltrace.cycles-pp.read.stress_metamix
      4.69 ± 46%      -4.7        0.00        perf-profile.calltrace.cycles-pp.iomap_writepage_map_blocks.iomap_writepage_map.iomap_writepages.xfs_vm_writepages.do_writepages
      4.68 ± 63%      -4.7        0.00        perf-profile.calltrace.cycles-pp.unlink.stress_metamix
      4.66 ± 63%      -4.7        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink.stress_metamix
      4.66 ± 63%      -4.7        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink.stress_metamix
      4.64 ± 63%      -4.6        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink.stress_metamix
      4.64 ± 63%      -4.6        0.00        perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      4.12 ± 48%      -4.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read.stress_metamix
      4.08 ± 48%      -4.1        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_metamix
      4.01 ± 64%      -4.0        0.00        perf-profile.calltrace.cycles-pp.evict.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.00 ± 64%      -4.0        0.00        perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlink.do_syscall_64
      3.96 ± 48%      -4.0        0.00        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.stress_metamix
      3.88 ± 52%      -3.9        0.00        perf-profile.calltrace.cycles-pp.iomap_submit_ioend.iomap_writepage_map_blocks.iomap_writepage_map.iomap_writepages.xfs_vm_writepages
      3.87 ± 53%      -3.9        0.00        perf-profile.calltrace.cycles-pp.submit_bio_noacct_nocheck.iomap_submit_ioend.iomap_writepage_map_blocks.iomap_writepage_map.iomap_writepages
      3.86 ± 53%      -3.9        0.00        perf-profile.calltrace.cycles-pp.__submit_bio.submit_bio_noacct_nocheck.iomap_submit_ioend.iomap_writepage_map_blocks.iomap_writepage_map
      6.96 ± 11%      -3.3        3.62 ± 29%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      6.29 ± 14%      -3.1        3.16 ± 28%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.65 ± 64%      +0.5        1.12 ± 25%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.handle_softirqs.__irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single
      0.22 ±141%      +0.6        0.85 ± 28%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.11 ±223%      +0.6        0.74 ± 28%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.22 ±141%      +0.7        0.88 ± 27%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.22 ±141%      +0.7        0.88 ± 27%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.50 ± 76%      +0.7        1.15 ± 25%  perf-profile.calltrace.cycles-pp.__sysvec_posted_msi_notification.sysvec_posted_msi_notification.asm_sysvec_posted_msi_notification.acpi_safe_halt.acpi_idle_enter
      0.22 ±142%      +0.7        0.94 ± 25%  perf-profile.calltrace.cycles-pp.__open64_nocancel.setlocale
      0.27 ±141%      +0.8        1.07 ± 28%  perf-profile.calltrace.cycles-pp.write
      0.33 ±102%      +0.8        1.14 ± 22%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.22 ±145%      +0.8        1.05 ± 24%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.43 ±108%      +0.9        1.35 ± 24%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.16 ±223%      +1.0        1.17 ± 36%  perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.__submit_bio.submit_bio_noacct_nocheck.iomap_submit_ioend.iomap_writepages
      0.15 ±223%      +1.1        1.20 ± 38%  perf-profile.calltrace.cycles-pp.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue
      0.66 ± 98%      +1.1        1.76 ± 33%  perf-profile.calltrace.cycles-pp.cmd_stat.run_builtin.handle_internal_command.main
      0.66 ± 98%      +1.1        1.76 ± 33%  perf-profile.calltrace.cycles-pp.dispatch_events.cmd_stat.run_builtin.handle_internal_command.main
      0.66 ± 98%      +1.1        1.76 ± 33%  perf-profile.calltrace.cycles-pp.process_interval.dispatch_events.cmd_stat.run_builtin.handle_internal_command
      0.54 ±119%      +1.1        1.68 ± 34%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.exit_mm.do_exit.do_group_exit
      0.54 ±118%      +1.2        1.70 ± 33%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.54 ±118%      +1.2        1.70 ± 33%  perf-profile.calltrace.cycles-pp.mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      1.56 ± 19%      +1.2        2.73 ± 22%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +1.2        1.18 ± 40%  perf-profile.calltrace.cycles-pp.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests
      0.45 ±148%      +1.2        1.66 ± 33%  perf-profile.calltrace.cycles-pp.read_counters.process_interval.dispatch_events.cmd_stat.run_builtin
      0.72 ± 98%      +1.3        1.99 ± 32%  perf-profile.calltrace.cycles-pp.handle_internal_command.main
      0.72 ± 98%      +1.3        1.99 ± 32%  perf-profile.calltrace.cycles-pp.main
      0.72 ± 98%      +1.3        1.99 ± 32%  perf-profile.calltrace.cycles-pp.run_builtin.handle_internal_command.main
      0.48 ±151%      +1.3        1.76 ± 32%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.80 ± 20%      +1.3        3.10 ± 23%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.82 ± 20%      +1.3        3.12 ± 23%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.64 ±114%      +1.4        2.00 ± 32%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64 ±114%      +1.4        2.00 ± 32%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
      0.64 ±114%      +1.4        2.00 ± 32%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.52 ±109%      +1.4        1.88 ± 27%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.53 ±109%      +1.4        1.92 ± 28%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.93 ± 83%      +1.4        2.32 ± 32%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.91 ± 89%      +1.5        2.41 ± 42%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.71 ±110%      +1.6        2.32 ± 42%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.66 ±112%      +1.7        2.35 ± 30%  perf-profile.calltrace.cycles-pp.setlocale
      2.08 ± 26%      +1.7        3.82 ± 29%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.05 ± 78%      +1.9        2.94 ± 28%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.46 ± 49%      +1.9        3.35 ± 19%  perf-profile.calltrace.cycles-pp.asm_sysvec_posted_msi_notification.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      1.10 ± 78%      +1.9        3.02 ± 28%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      1.10 ± 78%      +1.9        3.02 ± 28%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.30 ± 69%      +2.0        3.28 ± 32%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      1.32 ± 68%      +2.0        3.30 ± 31%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      1.32 ± 68%      +2.0        3.30 ± 31%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      1.43 ± 70%      +2.0        3.45 ± 30%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.11 ± 78%      +2.1        3.24 ± 27%  perf-profile.calltrace.cycles-pp.read
      2.01 ± 71%      +3.0        4.99 ± 22%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      2.01 ± 71%      +3.0        5.00 ± 22%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      2.01 ± 71%      +3.0        5.00 ± 22%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      2.01 ± 71%      +3.0        5.00 ± 22%  perf-profile.calltrace.cycles-pp.execve
      2.00 ± 70%      +3.0        4.99 ± 22%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.01 ± 54%      +3.3        4.27 ± 31%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests
      1.01 ± 54%      +3.4        4.36 ± 30%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests
      1.05 ± 55%      +3.4        4.47 ± 31%  perf-profile.calltrace.cycles-pp.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue
      2.33 ± 39%      +4.0        6.29 ± 28%  perf-profile.calltrace.cycles-pp.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list
      2.33 ± 39%      +4.0        6.31 ± 28%  perf-profile.calltrace.cycles-pp.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list.__blk_flush_plug
      2.35 ± 39%      +4.0        6.35 ± 27%  perf-profile.calltrace.cycles-pp.blk_mq_run_hw_queue.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list.__blk_flush_plug.__submit_bio
      1.71 ± 50%      +4.5        6.23 ± 29%  perf-profile.calltrace.cycles-pp.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue.blk_mq_dispatch_plug_list
      3.24 ± 66%      +4.8        8.01 ± 27%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.24 ± 66%      +4.8        8.04 ± 27%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.55 ± 40%      +5.2        8.77 ± 29%  perf-profile.calltrace.cycles-pp.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list.__blk_flush_plug.__submit_bio.submit_bio_noacct_nocheck
      3.55 ± 40%      +5.2        8.77 ± 29%  perf-profile.calltrace.cycles-pp.blk_mq_flush_plug_list.__blk_flush_plug.__submit_bio.submit_bio_noacct_nocheck.iomap_submit_ioend
      3.98 ± 55%      +8.1       12.11 ± 30%  perf-profile.calltrace.cycles-pp.xfs_file_write_checks.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
      0.56 ±164%      +8.2        8.77 ± 29%  perf-profile.calltrace.cycles-pp.__blk_flush_plug.__submit_bio.submit_bio_noacct_nocheck.iomap_submit_ioend.iomap_writepages
      3.33 ± 56%      +8.3       11.60 ± 31%  perf-profile.calltrace.cycles-pp.iomap_zero_range.xfs_file_write_checks.xfs_file_buffered_write.vfs_write.ksys_write
      0.91 ±108%      +9.0        9.94 ± 29%  perf-profile.calltrace.cycles-pp.__submit_bio.submit_bio_noacct_nocheck.iomap_submit_ioend.iomap_writepages.xfs_vm_writepages
      0.91 ±108%      +9.0        9.94 ± 29%  perf-profile.calltrace.cycles-pp.submit_bio_noacct_nocheck.iomap_submit_ioend.iomap_writepages.xfs_vm_writepages.do_writepages
      0.92 ±107%      +9.0        9.95 ± 29%  perf-profile.calltrace.cycles-pp.iomap_submit_ioend.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc
      0.00           +10.3       10.29 ± 30%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.filemap_write_and_wait_range.iomap_zero_range
      0.00           +10.3       10.29 ± 30%  perf-profile.calltrace.cycles-pp.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.filemap_write_and_wait_range
      0.00           +10.4       10.40 ± 30%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.filemap_write_and_wait_range.iomap_zero_range.xfs_file_write_checks.xfs_file_buffered_write
      0.00           +10.4       10.40 ± 30%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.filemap_write_and_wait_range.iomap_zero_range.xfs_file_write_checks
      0.00           +11.2       11.22 ± 30%  perf-profile.calltrace.cycles-pp.filemap_write_and_wait_range.iomap_zero_range.xfs_file_write_checks.xfs_file_buffered_write.vfs_write
     12.24 ± 39%     -12.2        0.00        perf-profile.children.cycles-pp.fdatasync
     12.02 ± 40%     -12.0        0.00        perf-profile.children.cycles-pp.__x64_sys_fdatasync
     12.02 ± 40%     -12.0        0.00        perf-profile.children.cycles-pp.xfs_file_fsync
      9.68 ± 50%      -9.1        0.57 ± 69%  perf-profile.children.cycles-pp.iomap_file_buffered_write
      8.37 ± 50%      -7.8        0.53 ± 66%  perf-profile.children.cycles-pp.iomap_write_iter
      7.12 ± 30%      -7.1        0.00        perf-profile.children.cycles-pp.file_write_and_wait_range
      6.48 ± 49%      -6.1        0.35 ± 65%  perf-profile.children.cycles-pp.iomap_write_begin
      5.25 ± 45%      -5.0        0.22 ± 74%  perf-profile.children.cycles-pp.iomap_writepage_map
      4.74 ± 60%      -4.7        0.00        perf-profile.children.cycles-pp.unlink
      4.69 ± 60%      -4.7        0.00        perf-profile.children.cycles-pp.__x64_sys_unlink
      4.69 ± 60%      -4.7        0.00        perf-profile.children.cycles-pp.do_unlinkat
      4.70 ± 46%      -4.6        0.14 ± 97%  perf-profile.children.cycles-pp.iomap_writepage_map_blocks
      4.31 ± 55%      -4.2        0.16 ±108%  perf-profile.children.cycles-pp.iomap_iter
      4.13 ± 61%      -4.1        0.00        perf-profile.children.cycles-pp.truncate_inode_pages_range
      4.06 ± 61%      -4.1        0.01 ±223%  perf-profile.children.cycles-pp.evict
      3.90 ± 48%      -3.8        0.11 ± 82%  perf-profile.children.cycles-pp.__iomap_write_begin
      3.82 ± 56%      -3.7        0.08 ± 80%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      3.42 ± 47%      -3.4        0.07 ±111%  perf-profile.children.cycles-pp.zero_user_segments
      6.97 ± 11%      -3.4        3.62 ± 29%  perf-profile.children.cycles-pp.worker_thread
      3.45 ± 46%      -3.2        0.24 ± 35%  perf-profile.children.cycles-pp.memset_orig
      3.25 ± 45%      -3.1        0.11 ± 88%  perf-profile.children.cycles-pp.filemap_read
      6.29 ± 14%      -3.1        3.16 ± 28%  perf-profile.children.cycles-pp.process_one_work
      3.18 ± 54%      -2.6        0.59 ± 50%  perf-profile.children.cycles-pp.folios_put_refs
      2.46 ± 67%      -2.4        0.10 ± 65%  perf-profile.children.cycles-pp.__page_cache_release
      2.51 ± 50%      -2.2        0.28 ± 52%  perf-profile.children.cycles-pp.__filemap_get_folio
      1.58 ± 51%      -1.5        0.10 ± 84%  perf-profile.children.cycles-pp.filemap_add_folio
      1.52 ± 45%      -1.4        0.10 ±119%  perf-profile.children.cycles-pp.copy_page_to_iter
      1.48 ± 44%      -1.4        0.12 ± 75%  perf-profile.children.cycles-pp._copy_to_iter
      2.55 ± 16%      -1.1        1.41 ± 36%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.22 ± 24%      -1.1        0.10 ± 71%  perf-profile.children.cycles-pp.mod_delayed_work_on
      1.16 ± 50%      -1.0        0.13 ± 78%  perf-profile.children.cycles-pp.open64
      0.95 ± 31%      -0.9        0.06 ± 84%  perf-profile.children.cycles-pp.try_to_grab_pending
      0.99 ± 45%      -0.9        0.10 ± 71%  perf-profile.children.cycles-pp.kblockd_mod_delayed_work_on
      0.88 ± 50%      -0.8        0.06 ±111%  perf-profile.children.cycles-pp.filemap_get_pages
      0.81 ± 48%      -0.7        0.06 ±113%  perf-profile.children.cycles-pp.filemap_get_read_batch
      1.08 ± 28%      -0.6        0.45 ± 39%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.70 ± 51%      -0.6        0.08 ±125%  perf-profile.children.cycles-pp.folio_alloc_noprof
      0.66 ± 53%      -0.6        0.06 ± 84%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.59 ± 32%      -0.6        0.04 ±100%  perf-profile.children.cycles-pp.xfs_map_blocks
      0.88 ± 14%      -0.5        0.38 ± 51%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.58 ± 38%      -0.5        0.13 ± 81%  perf-profile.children.cycles-pp.writeback_iter
      0.71 ± 29%      -0.4        0.26 ± 51%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.52 ± 43%      -0.4        0.12 ± 91%  perf-profile.children.cycles-pp.writeback_get_folio
      0.44 ± 53%      -0.4        0.06 ±130%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.49 ± 20%      -0.4        0.12 ± 62%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.35 ± 38%      -0.3        0.08 ± 54%  perf-profile.children.cycles-pp.touch_atime
      0.63 ± 23%      -0.3        0.37 ± 66%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.47 ± 33%      -0.3        0.21 ± 79%  perf-profile.children.cycles-pp.xas_load
      0.30 ± 35%      -0.2        0.09 ± 86%  perf-profile.children.cycles-pp.rmqueue
      0.24 ± 29%      -0.2        0.05 ± 71%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.13 ± 22%      -0.1        0.04 ±101%  perf-profile.children.cycles-pp.lock_timer_base
      0.16 ± 31%      -0.1        0.08 ± 85%  perf-profile.children.cycles-pp.xas_find
      0.16 ± 22%      -0.1        0.08 ± 78%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.05 ± 78%      +0.1        0.12 ± 37%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.change_protection_range
      0.13 ± 33%      +0.1        0.21 ± 38%  perf-profile.children.cycles-pp.wakeup_preempt
      0.05 ±108%      +0.1        0.14 ± 24%  perf-profile.children.cycles-pp.perf_event_read
      0.05 ±108%      +0.1        0.14 ± 24%  perf-profile.children.cycles-pp.smp_call_function_single
      0.04 ±118%      +0.1        0.14 ± 37%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.02 ±143%      +0.1        0.12 ± 60%  perf-profile.children.cycles-pp.__poll
      0.02 ±143%      +0.1        0.12 ± 60%  perf-profile.children.cycles-pp.__x64_sys_poll
      0.02 ±143%      +0.1        0.12 ± 60%  perf-profile.children.cycles-pp.do_sys_poll
      0.01 ±223%      +0.1        0.11 ± 48%  perf-profile.children.cycles-pp.lockref_put_return
      0.02 ±142%      +0.1        0.12 ± 60%  perf-profile.children.cycles-pp.do_poll
      0.07 ± 75%      +0.1        0.18 ± 34%  perf-profile.children.cycles-pp.switch_fpu_return
      0.04 ±112%      +0.1        0.15 ± 66%  perf-profile.children.cycles-pp.getenv
      0.01 ±223%      +0.1        0.12 ± 39%  perf-profile.children.cycles-pp.folio_putback_lru
      0.04 ±114%      +0.1        0.16 ± 37%  perf-profile.children.cycles-pp.generic_exec_single
      0.02 ±223%      +0.1        0.14 ± 38%  perf-profile.children.cycles-pp.expand_downwards
      0.12 ± 44%      +0.1        0.24 ± 15%  perf-profile.children.cycles-pp.__check_object_size
      0.14 ± 29%      +0.1        0.27 ± 19%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.01 ±223%      +0.1        0.14 ± 37%  perf-profile.children.cycles-pp.xfsaild
      0.01 ±223%      +0.1        0.14 ± 37%  perf-profile.children.cycles-pp.xfsaild_push
      0.01 ±223%      +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.get_cpu_sleep_time_us
      0.06 ± 83%      +0.1        0.19 ± 62%  perf-profile.children.cycles-pp.__d_add
      0.10 ± 92%      +0.1        0.24 ± 15%  perf-profile.children.cycles-pp.shift_arg_pages
      0.00            +0.1        0.14 ± 37%  perf-profile.children.cycles-pp.get_idle_time
      0.13 ± 37%      +0.1        0.27 ± 19%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      0.11 ± 80%      +0.1        0.26 ± 39%  perf-profile.children.cycles-pp.mm_init
      0.07 ± 49%      +0.1        0.22 ± 35%  perf-profile.children.cycles-pp.pte_alloc_one
      0.22 ± 47%      +0.2        0.37 ± 33%  perf-profile.children.cycles-pp.scsi_mq_get_budget
      0.06 ±103%      +0.2        0.21 ± 53%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.14 ± 79%      +0.2        0.30 ± 30%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.04 ±107%      +0.2        0.20 ± 70%  perf-profile.children.cycles-pp.dyntick_save_progress_counter
      0.05 ±132%      +0.2        0.22 ± 66%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.05 ±136%      +0.2        0.22 ± 66%  perf-profile.children.cycles-pp.dev_attr_show
      0.07 ± 89%      +0.2        0.24 ± 28%  perf-profile.children.cycles-pp.__cmd_record
      0.07 ± 89%      +0.2        0.24 ± 28%  perf-profile.children.cycles-pp.cmd_record
      0.05 ±125%      +0.2        0.22 ± 43%  perf-profile.children.cycles-pp.move_queued_task
      0.08 ± 14%      +0.2        0.26 ± 51%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.07 ±127%      +0.2        0.25 ± 31%  perf-profile.children.cycles-pp.__dentry_kill
      0.04 ± 77%      +0.2        0.22 ± 62%  perf-profile.children.cycles-pp.mas_split
      0.08 ± 27%      +0.2        0.27 ± 47%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.14 ± 62%      +0.2        0.34 ± 29%  perf-profile.children.cycles-pp.create_elf_tables
      0.01 ±223%      +0.2        0.21 ± 60%  perf-profile.children.cycles-pp.__put_user_8
      0.12 ± 64%      +0.2        0.32 ± 48%  perf-profile.children.cycles-pp.seq_printf
      0.21 ± 36%      +0.2        0.43 ± 37%  perf-profile.children.cycles-pp.vfs_statx
      0.23 ± 73%      +0.2        0.45 ± 38%  perf-profile.children.cycles-pp.sbitmap_get
      0.15 ±104%      +0.2        0.38 ± 52%  perf-profile.children.cycles-pp.get_arg_page
      0.24 ± 70%      +0.2        0.47 ± 42%  perf-profile.children.cycles-pp.load_elf_interp
      0.08 ± 52%      +0.2        0.31 ± 44%  perf-profile.children.cycles-pp.__get_user_8
      0.13 ± 48%      +0.3        0.38 ± 51%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      0.21 ± 66%      +0.3        0.46 ± 46%  perf-profile.children.cycles-pp.vsnprintf
      0.12 ± 61%      +0.3        0.38 ± 30%  perf-profile.children.cycles-pp.slab_show
      0.15 ± 65%      +0.3        0.40 ± 50%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.23 ± 32%      +0.3        0.49 ± 32%  perf-profile.children.cycles-pp.path_lookupat
      0.13 ± 82%      +0.3        0.40 ± 50%  perf-profile.children.cycles-pp.perf_evsel__read
      0.13 ± 62%      +0.3        0.40 ± 24%  perf-profile.children.cycles-pp.step_into
      0.14 ± 70%      +0.3        0.42 ± 35%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.23 ± 32%      +0.3        0.51 ± 28%  perf-profile.children.cycles-pp.filename_lookup
      0.06 ± 88%      +0.3        0.34 ± 48%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.18 ± 39%      +0.3        0.47 ± 38%  perf-profile.children.cycles-pp.dput
      0.16 ± 43%      +0.3        0.45 ± 37%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.28 ± 69%      +0.3        0.57 ± 32%  perf-profile.children.cycles-pp.__vfork
      0.24 ± 68%      +0.3        0.54 ± 29%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.09 ± 65%      +0.3        0.42 ± 38%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.36 ± 40%      +0.3        0.68 ± 27%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.23 ± 66%      +0.3        0.58 ± 56%  perf-profile.children.cycles-pp.free_pgtables
      0.32 ± 42%      +0.4        0.67 ± 30%  perf-profile.children.cycles-pp.tick_irq_enter
      0.43 ± 39%      +0.4        0.78 ± 19%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.21 ± 55%      +0.4        0.57 ± 41%  perf-profile.children.cycles-pp.readn
      0.16 ± 33%      +0.4        0.52 ± 50%  perf-profile.children.cycles-pp.dup_mmap
      0.15 ± 77%      +0.4        0.51 ± 39%  perf-profile.children.cycles-pp.show_stat
      0.34 ± 69%      +0.4        0.71 ± 42%  perf-profile.children.cycles-pp.zap_present_ptes
      0.21 ± 67%      +0.4        0.60 ± 23%  perf-profile.children.cycles-pp.i2c_outb
      0.23 ± 79%      +0.4        0.62 ± 36%  perf-profile.children.cycles-pp.seq_read
      0.18 ± 40%      +0.4        0.59 ± 46%  perf-profile.children.cycles-pp.dup_mm
      0.30 ± 67%      +0.4        0.72 ± 36%  perf-profile.children.cycles-pp.tmigr_handle_remote_up
      0.20 ± 65%      +0.4        0.63 ± 58%  perf-profile.children.cycles-pp.sync_regs
      0.25 ± 66%      +0.4        0.68 ± 23%  perf-profile.children.cycles-pp.try_address
      0.27 ± 74%      +0.5        0.72 ± 24%  perf-profile.children.cycles-pp.output_poll_execute
      0.28 ± 70%      +0.5        0.74 ± 28%  perf-profile.children.cycles-pp.pipe_read
      0.26 ± 70%      +0.5        0.72 ± 24%  perf-profile.children.cycles-pp.__i2c_transfer
      0.26 ± 70%      +0.5        0.72 ± 24%  perf-profile.children.cycles-pp.bit_xfer
      0.26 ± 70%      +0.5        0.72 ± 24%  perf-profile.children.cycles-pp.drm_connector_helper_detect_from_ddc
      0.26 ± 70%      +0.5        0.72 ± 24%  perf-profile.children.cycles-pp.drm_do_probe_ddc_edid
      0.26 ± 70%      +0.5        0.72 ± 24%  perf-profile.children.cycles-pp.drm_helper_probe_detect_ctx
      0.26 ± 70%      +0.5        0.72 ± 24%  perf-profile.children.cycles-pp.drm_probe_ddc
      0.26 ± 70%      +0.5        0.72 ± 24%  perf-profile.children.cycles-pp.i2c_transfer
      0.14 ± 61%      +0.5        0.61 ± 35%  perf-profile.children.cycles-pp.balance_fair
      0.23 ± 68%      +0.5        0.69 ± 34%  perf-profile.children.cycles-pp.folio_wait_bit_common
      0.28 ± 81%      +0.5        0.77 ± 29%  perf-profile.children.cycles-pp.pipe_write
      0.35 ± 68%      +0.5        0.84 ± 41%  perf-profile.children.cycles-pp.tmigr_handle_remote
      0.24 ± 81%      +0.5        0.74 ± 34%  perf-profile.children.cycles-pp.copy_strings
      0.27 ± 72%      +0.5        0.78 ± 50%  perf-profile.children.cycles-pp.exec_mmap
      0.19 ± 83%      +0.5        0.70 ± 34%  perf-profile.children.cycles-pp.folio_wait_writeback
      0.30 ± 67%      +0.5        0.83 ± 31%  perf-profile.children.cycles-pp.do_anonymous_page
      0.44 ± 59%      +0.6        1.00 ± 46%  perf-profile.children.cycles-pp.zap_pmd_range
      0.35 ± 86%      +0.6        0.93 ± 31%  perf-profile.children.cycles-pp.collapse_huge_page
      0.36 ± 84%      +0.6        0.93 ± 30%  perf-profile.children.cycles-pp.khugepaged
      0.35 ± 85%      +0.6        0.93 ± 30%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      0.35 ± 85%      +0.6        0.93 ± 30%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.34 ± 63%      +0.6        0.92 ± 37%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      0.24 ± 42%      +0.6        0.89 ± 47%  perf-profile.children.cycles-pp.scsi_dispatch_cmd
      0.32 ± 62%      +0.7        0.99 ± 45%  perf-profile.children.cycles-pp.begin_new_exec
      0.41 ± 58%      +0.7        1.10 ± 21%  perf-profile.children.cycles-pp.__open64_nocancel
      0.37 ± 48%      +0.7        1.06 ± 34%  perf-profile.children.cycles-pp._Fork
      0.54 ± 66%      +0.7        1.27 ± 29%  perf-profile.children.cycles-pp.sched_setaffinity
      0.78 ± 51%      +0.8        1.56 ± 28%  perf-profile.children.cycles-pp.link_path_walk
      0.40 ± 35%      +0.8        1.19 ± 40%  perf-profile.children.cycles-pp.scsi_queue_rq
      0.51 ± 74%      +0.8        1.30 ± 39%  perf-profile.children.cycles-pp.elf_load
      0.34 ± 54%      +0.8        1.15 ± 34%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.72 ± 69%      +0.9        1.66 ± 33%  perf-profile.children.cycles-pp.read_counters
      0.77 ± 70%      +1.0        1.76 ± 33%  perf-profile.children.cycles-pp.cmd_stat
      0.77 ± 70%      +1.0        1.76 ± 33%  perf-profile.children.cycles-pp.dispatch_events
      0.77 ± 70%      +1.0        1.76 ± 33%  perf-profile.children.cycles-pp.process_interval
      1.00 ± 19%      +1.0        2.01 ± 26%  perf-profile.children.cycles-pp.filemap_map_pages
      1.39 ± 34%      +1.1        2.48 ± 22%  perf-profile.children.cycles-pp.asm_sysvec_posted_msi_notification
      0.85 ± 68%      +1.1        1.99 ± 32%  perf-profile.children.cycles-pp.handle_internal_command
      0.85 ± 68%      +1.1        1.99 ± 32%  perf-profile.children.cycles-pp.main
      0.85 ± 68%      +1.1        1.99 ± 32%  perf-profile.children.cycles-pp.run_builtin
      0.88 ± 64%      +1.2        2.04 ± 32%  perf-profile.children.cycles-pp.do_group_exit
      0.88 ± 64%      +1.2        2.05 ± 32%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.64 ± 66%      +1.2        1.87 ± 37%  perf-profile.children.cycles-pp.seq_read_iter
      1.24 ± 54%      +1.2        2.48 ± 31%  perf-profile.children.cycles-pp.x64_sys_call
      1.03 ± 66%      +1.3        2.30 ± 30%  perf-profile.children.cycles-pp.do_exit
      0.88 ± 64%      +1.5        2.35 ± 30%  perf-profile.children.cycles-pp.setlocale
      1.08 ± 71%      +1.5        2.56 ± 26%  perf-profile.children.cycles-pp.mmput
      1.05 ± 70%      +1.5        2.55 ± 27%  perf-profile.children.cycles-pp.exit_mmap
      3.54 ± 34%      +1.8        5.33 ± 20%  perf-profile.children.cycles-pp.handle_softirqs
      1.61 ± 55%      +1.8        3.40 ± 35%  perf-profile.children.cycles-pp.mmap_region
      1.30 ± 69%      +2.0        3.28 ± 32%  perf-profile.children.cycles-pp.load_elf_binary
      1.32 ± 68%      +2.0        3.30 ± 31%  perf-profile.children.cycles-pp.search_binary_handler
      1.32 ± 68%      +2.0        3.32 ± 31%  perf-profile.children.cycles-pp.exec_binprm
      1.45 ± 70%      +2.1        3.52 ± 30%  perf-profile.children.cycles-pp.bprm_execve
      2.01 ± 71%      +3.0        5.01 ± 22%  perf-profile.children.cycles-pp.__x64_sys_execve
      2.01 ± 71%      +3.0        5.01 ± 23%  perf-profile.children.cycles-pp.execve
      2.00 ± 70%      +3.0        5.01 ± 22%  perf-profile.children.cycles-pp.do_execveat_common
      1.18 ± 39%      +3.3        4.48 ± 31%  perf-profile.children.cycles-pp.dd_dispatch_request
      2.77 ± 34%      +3.6        6.33 ± 28%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
      2.77 ± 34%      +3.6        6.34 ± 28%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
      2.59 ± 34%      +3.8        6.35 ± 27%  perf-profile.children.cycles-pp.blk_mq_run_hw_queue
      1.94 ± 37%      +4.3        6.24 ± 29%  perf-profile.children.cycles-pp.__blk_mq_do_dispatch_sched
      3.76 ± 36%      +5.0        8.79 ± 30%  perf-profile.children.cycles-pp.__blk_flush_plug
      3.76 ± 36%      +5.0        8.79 ± 30%  perf-profile.children.cycles-pp.blk_mq_dispatch_plug_list
      3.76 ± 36%      +5.0        8.79 ± 30%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      4.84 ± 35%      +5.1        9.96 ± 29%  perf-profile.children.cycles-pp.iomap_submit_ioend
      4.01 ± 55%      +8.1       12.11 ± 30%  perf-profile.children.cycles-pp.xfs_file_write_checks
      3.34 ± 56%      +8.3       11.60 ± 31%  perf-profile.children.cycles-pp.iomap_zero_range
      0.00           +11.2       11.22 ± 30%  perf-profile.children.cycles-pp.filemap_write_and_wait_range
      3.43 ± 46%      -3.2        0.24 ± 35%  perf-profile.self.cycles-pp.memset_orig
      1.42 ± 47%      -1.3        0.08 ±121%  perf-profile.self.cycles-pp._copy_to_iter
      1.07 ± 27%      -0.6        0.45 ± 39%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.38 ± 23%      -0.3        0.12 ± 62%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.30 ± 33%      -0.2        0.09 ± 88%  perf-profile.self.cycles-pp.do_syscall_64
      0.22 ± 30%      -0.2        0.05 ± 71%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.13 ± 20%      -0.1        0.04 ±103%  perf-profile.self.cycles-pp.__page_cache_release
      0.01 ±223%      +0.1        0.11 ± 48%  perf-profile.self.cycles-pp.lockref_put_return
      0.02 ±142%      +0.1        0.13 ± 65%  perf-profile.self.cycles-pp.xfs_ag_block_count
      0.01 ±223%      +0.1        0.13 ± 45%  perf-profile.self.cycles-pp.get_cpu_sleep_time_us
      0.04 ±112%      +0.2        0.19 ± 68%  perf-profile.self.cycles-pp.dyntick_save_progress_counter
      0.14 ± 35%      +0.2        0.31 ± 35%  perf-profile.self.cycles-pp.sched_balance_domains
      0.08 ± 52%      +0.2        0.31 ± 44%  perf-profile.self.cycles-pp.__get_user_8
      0.06 ± 92%      +0.3        0.34 ± 60%  perf-profile.self.cycles-pp.fold_vm_numa_events
      0.20 ± 65%      +0.4        0.63 ± 58%  perf-profile.self.cycles-pp.sync_regs
      0.26 ± 34%      +0.5        0.75 ± 37%  perf-profile.self.cycles-pp.filemap_map_pages




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


