Return-Path: <linux-fsdevel+bounces-67334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE13C3BF50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 16:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A72188F868
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E790347FCF;
	Thu,  6 Nov 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FvFABXw0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tfYkeFYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2E8342C88;
	Thu,  6 Nov 2025 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441424; cv=fail; b=lO2zj9GaCFebMOrCvhEKnZhttDS2Ds7xbf+cvu2pHRjlE2FTvJtnJnCHDQTn41zbUlQZgZXudsPtxdUx62a8Y/QTHfSEE9vNMSUF/oua5slFtj5NW2GvZOuRpmLnS5e6RISSIzfby/1sBa41MbESbJaopDKsstCyKZggByGEhoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441424; c=relaxed/simple;
	bh=T7aR4+5iJs+NK8oNOiRfGsVtJd6Tu0/kreR11lTeFW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BG45dPIJS/ePk95jcPD7iSOH8D+D94oH2A27rVeOkIkgxD/WaT074TUXx9VARZhzpdhVcKDv1Mmm2u0Fu/rOlhgfA5/LG7UeDR2qEQDyXDgQnRhtBx7QVcMi+HVohJVQ13VEcrZFn6Jo5BFT1xET8ieoYlHNYUqgKsR8WbcQRBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FvFABXw0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tfYkeFYJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6B6LvN031510;
	Thu, 6 Nov 2025 15:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=N5qKG5ljRnXobdU3Hf
	bbg/N+BQZMohDlUypDvpdeUGw=; b=FvFABXw09MEhWPLe1VD4/L88atjMR4hWOK
	aRT9/8Yg/GCfDCWfatv4VfjDpHYWnkcCw8F3xYHrIQdueG/SWAd+t2O7haXeUKPJ
	s6Pe6qnHftyzulGltYTJ+rMyKiqQLAXx/4DfshawK054wVHeZwBcgJL7lAMJTnXf
	/7L7nyGNJN2IjfN2PFsUqs+BAmQxtz5Ak/ISP/4HUUsAKxNEFYo8PeS8nk9mU6k/
	SXgte5RtfynuULuz4sL9u2NGfSRdI6mmOVrFh4pHo6sfn8U7GIdK+d65JDidIGW7
	ymHpUUAGZjpf8ZIhXzrfbVBZ0rRdHvulKi2QNYSY6O/WQXa7IWSQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a89q42dve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 15:03:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6EAr8a010866;
	Thu, 6 Nov 2025 15:03:16 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011005.outbound.protection.outlook.com [40.93.194.5])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncgx1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 15:03:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVIs68LXmufyZfZCCruVx8vSH4pt6nvgBhLul1XtKyhigdFyF9vRuhuYkaj7WW25gK1d6Ai65q00SOSw1K2ffBw4B7TjmvtlW1ZqY78XrL2aFKRrS9kEH1s4Hero5N0EzkZlwQBH0ZKEoCHwwTk4V0ipeIDzDAZzNpe4ZrCiym26T8Nza+elj1f1rFlGWilnwCcbusSAXZO9Z1xra3AsBkOuq81f/lZnXV2wznib50ksJFZHuyQeXuWkRSnuXsrEifDXUkN7B8XbA8GVX1j2fjcOcc9glIxELU3z8cMmqg1fnJuSOU1YaEelekkUp5S0871XCYyKIUlBZ9qfcr7+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5qKG5ljRnXobdU3Hfbbg/N+BQZMohDlUypDvpdeUGw=;
 b=kGULpwl00YNE9PGqOYgNh6H8tINCEAhIuyFQOThlCjwGao5/MnRI1qwVe+b3Ftw7Td8uE5nEfo3TOJnYWxlUo5Kp4E2TpR7NPIE5y5T6nAuCSux9vg6/wg3Lz/xblPc+dyJiYCMNY8vl/lnORIfMAjuHkvkieQo/TGgBEI6LKN6IXn8hJh5Gg22TW4q7jRSU2VooL1NUZKjw82OVy17EUtBcu6/DEm9yv/Y2l7T4OSUw9qATKsIwRq2C+9S/mfowiFqg7Shg4aGvkHStxL6ymRze6OmUsKle4+rFz6jEVOtm+ijXNKYiJ6qvcbRDGqgroOvxm/UEjMOYvEcRC9c7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5qKG5ljRnXobdU3Hfbbg/N+BQZMohDlUypDvpdeUGw=;
 b=tfYkeFYJn5dWYoMbE9U8p8BYdelMsFfeBuvfC8N/B/NGznlb/uIqA3MWMO3WjmR3p2yNzIoV4CxxNI9Kl4JRDf3AYJCV2FOQ1/du50Y7BK7OU7rEwxBdlx6rUX3jH+ynueInUfXL+/z3rnz5Bet2oE7jxH9MC6yyFTer5Z21Xx0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB5920.namprd10.prod.outlook.com (2603:10b6:8:af::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Thu, 6 Nov 2025 15:03:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 15:03:11 +0000
Date: Thu, 6 Nov 2025 15:03:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v2 2/5] mm: add atomic VMA flags, use VM_MAYBE_GUARD as
 such
Message-ID: <69c73e1e-c520-42e7-af0a-65f17f5e081e@lucifer.local>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
 <94935cf140e3279c234b39e0d976c4718c547c73.1762422915.git.lorenzo.stoakes@oracle.com>
 <y6a4qchmj7jnaogx6u5a3i6lni7v54lj25ipwb7tdtakcudakr@vm6vt7eumxax>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y6a4qchmj7jnaogx6u5a3i6lni7v54lj25ipwb7tdtakcudakr@vm6vt7eumxax>
X-ClientProxiedBy: LO6P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6c68ff-f767-4a97-33e1-08de1d459a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8c5DQj66QxDb8NnzAVzRt4LvqfPmbfMuno2z6rFg5aEyWaL96Le3FrXNPMV5?=
 =?us-ascii?Q?jB/p81HlPsscrJpuFTnL1EdIXzF/ylK8lxRKTRWmqkbdMZcbBaMdd/kFirdI?=
 =?us-ascii?Q?5dnSYz8/wyTY1HQKFpLcJf0uhNeWgK3H/aPflKaLYgT+PxDr1BMmKJZwnRc4?=
 =?us-ascii?Q?i8J9AQQrk00aOWUFvs3/F4/h5VbCr5V3eyqfTwQM7kxt0D2Gu7Wg+EH5W8Ja?=
 =?us-ascii?Q?S2WQDV/Ydc2+IGHH3Lm17/E+kWJKcr3y0kNF3Z+gpugg2mwMJVCCEtlLHCRD?=
 =?us-ascii?Q?rKiDgq5Ub4DkT5HNmzhESTvdbu94Y0h3QIwm1gM5uPuAxWe26Wnjg0nLZtbs?=
 =?us-ascii?Q?nnjgvHgzV2lV/mj7GuMusbatVvbiPD6w0vrSL4GxJbyCS1ggYOBr/KH+f2iu?=
 =?us-ascii?Q?WCYsY3+5+2OTASEjty+y9TExno5mojw4heWgEaKaVnun23QjSMz2nWZW6sFa?=
 =?us-ascii?Q?kkdEPJTIQnO/KMbJd0E4gFWYj3iYjVDA134oDb8k5Yb97NHVJBjAeqvdV5BK?=
 =?us-ascii?Q?dXK8PP+N1vZ4FSvodB5HCeLbLpNaNra1k4wXkbbVAw87At3H/QgGlFenNfLa?=
 =?us-ascii?Q?qSjQGN8pJ/OpNe5664NuGUZdV8NH3yQDTOtCvFZpLDEp8RSVxoW6Hx2pDKKB?=
 =?us-ascii?Q?1ABi2lN/aGTDoSygHWZoSGlywYylPqeVTVKV8ew+uMExPVxW8Qj2c0lMefeS?=
 =?us-ascii?Q?QQSJn8hixpC/LIvim8r0G2azbMRnigjFWI15PVKVOkwtWZ+KRgzBuumVA/2Z?=
 =?us-ascii?Q?HRLf10XJDm7OYtvpcrHsbbLeaUPWE6xTT05RkhDDXU8d/Cdmr+WF8U6sWyDB?=
 =?us-ascii?Q?66N6p7D/vLuK39W+CcWCFyuChx7K8Ym7ywaRoHA9R86im57TvRCCmuR8Lb3G?=
 =?us-ascii?Q?nNmCgbp3Yq8Fzs9R+VtmYJ9NGkNHOSdHTV2f99Cis2ew9vciUJ0J5QG6/q/e?=
 =?us-ascii?Q?R9Fgj8JrBb4e1nNomIAhANn3PcSpb/OeNbCfTCtuwTOSYUeLWWX8OwDPAV+Z?=
 =?us-ascii?Q?CaAeoD+ui90CtnIMxxis3x+8G3+r98QPJbWy6RqeZ8sP7BkUEAk1A7PvtGr+?=
 =?us-ascii?Q?W/9sHKVypGTmduE+mxXYi3ZmiBpm0DhbJmOqJ2SY2CbPTYtdqHlkWDzlGxEe?=
 =?us-ascii?Q?Hl2UanHYAXMTmQ5KELESTenLWAMMNiQonh6WfzjZ5Lqo0e+67/3+MPVwTeSo?=
 =?us-ascii?Q?b4OdOdI7JOfW50z+rWscsNj59A+u7pZkVHJwiGricGVIQsjF5XLv7MISU9xt?=
 =?us-ascii?Q?7UnSbH6akGXMmKRnpzDVdZ66P61/gdcQQPr30P9ivxvIXPGY3ix/hf2W8lV9?=
 =?us-ascii?Q?bj3+ENSjBPPJhPqJ9yZ3J/UuV2vYUWxmfrQaCQktIAWwvFDBA54SjAJnRFSR?=
 =?us-ascii?Q?SAMVmKmi6YEDCka17Mq+aO1TRH7iHiFeeB/bNGZr82LwsOWYGw3ZkE3wQo03?=
 =?us-ascii?Q?oz01Fp9/8o0r0HV32XCg374qvKz0h7aCrIb2zMOhSz+OaOfK02vBSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J/AGah4rVl1Ydtv65n9hphPi2uFcmWPBEwFq4RIF5Zg7iO28DXGri9Uu7B0c?=
 =?us-ascii?Q?22LsdoZWo1ZMxXeOEA3N6VUDRZp8nxHMl79myVI4uDn3hVJHQXUCkNho+O/b?=
 =?us-ascii?Q?vqX0pVUa3Kj6uCP7y/RKRWAT0ugAamNvTaLosEPwHQHHV5EtuOCrY2n4Qrc1?=
 =?us-ascii?Q?tWm6jDHRuEAiQ7zADUzTjzdvwSP3Tvlh7zOirhvzos0djdt3C5lTmay4BxV7?=
 =?us-ascii?Q?8TFa5oWaS7oMjF+W7qb46iDhJMxkkQ6t9rLX8w/8PWWFVLd1cUeQVYhBxGGD?=
 =?us-ascii?Q?irJ5eykAuKMGNiwm/ves0x/Am/GMlAFuTSBAXv3OpF4kvJZI/Rv/70ZitNpP?=
 =?us-ascii?Q?1USw1ubGLqClzE5w1e4d1xBVNE08MQjCD3RfqeRBBakT81v6FdWhxVHNdUgH?=
 =?us-ascii?Q?YuaP6jSrEDMnKnNiuYBlZvK3wIYGZeLW/DfZF7rfEshNPioSSFjqsx3ASJEn?=
 =?us-ascii?Q?6btj0MD+zpMdbQLnrJ//BTJQ/fgasD5FyFeCW4vsOM5eGI1TKsFsbT0YtaZp?=
 =?us-ascii?Q?BibHDZYR++3pfJIFZNK/qXJQ6RWRQuxq2jYxabjiekhQ2wNQNbYDIMO/uPrs?=
 =?us-ascii?Q?ab9qQfZNhiQsiMtm036JzGoDj9JwPfelTgKZLtnQNxaAdBtU+T5LxT8cLuN4?=
 =?us-ascii?Q?hkdE4OLnnuUxtgK/cyRt4vfuUX34uwo5JFloaqSqHGqr2FTcwKorAnbCO8iZ?=
 =?us-ascii?Q?F5EXt6r3s0BF2lR31kTDP05u0cEGvChts0/wGlRlYHrqvIvRM6Tc2JBsZN7i?=
 =?us-ascii?Q?/Gtr65y74j8li9jIRWzQfRe0eMDSb+HIPCh9lCw3XP3fH5xi+QW/a4RPuxAz?=
 =?us-ascii?Q?QbrtZgqn7J2reLqYf9KSSffq3iz79JXZtgJRQ9JpIe5GrkIbejI91XidZsgu?=
 =?us-ascii?Q?spMcd9CFteVLGOuv3RyP+j4hlyifkVyOtLcaj3EMiZ1H6nOobLvNpJ2i3//t?=
 =?us-ascii?Q?ikRqfj7vtNikN41vCfg2dBTBOHxVWso7DcBCIHgGG1jJmwTbP1Ipc32640KF?=
 =?us-ascii?Q?Ojn90iFm6lN2Sig7Gk5XLKo+6s8kEIy4kD4QvO3tQWBl4DId4I2Uegv3MVwQ?=
 =?us-ascii?Q?Yot7iCkRCamY2y0TORLsUAIMQtl8wKrJhc7ZrnwP7BIfs/oDvttmRJIwz/tg?=
 =?us-ascii?Q?zIkAszpIwu6l3ozdO6B85XL/fJ8qGnaZaj4Zb5r5IvKF+boPCt8LwIXygXlW?=
 =?us-ascii?Q?THyx5L4u2f0RjQvkavBUJ/NngL8fikxpG++tTdXrRrbqJvbiIuUtZcTeqgAs?=
 =?us-ascii?Q?fCyiI0h8sKXrZqLr/RB/5cVP52+Vypa7Z0PgPwGaAwP1sQPVLoEBhvln+zR5?=
 =?us-ascii?Q?hgvVfA9ScZYA8ek+4vMDPmfmBK0OPHnc9tbSh8W2YDfOTTvrbTs7MaHV6hhc?=
 =?us-ascii?Q?TRLbbngvXghlkXGosYfto8KutqwzkotHnqiVXaV/iQHDaXfoEskTQMQD4Shc?=
 =?us-ascii?Q?TZV+lXJGkxfv4yvwN9Gx57a69KcjuGbEUUdMqS+rQPcfCkI7GnH+e1bBACtr?=
 =?us-ascii?Q?PV0O3tj+MTVDeMVHEUpNXr7QnjswXUtp5j12W/kxI7DKKUa6F/YYrOmJyp/e?=
 =?us-ascii?Q?AQkQYtL67VocVS8TC+LfpamkU0AEGKs5O2l5sQFqavxAK9nq+Gnn/KSmHM/y?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rynpJxXeJyscVwp1w1dF5unZBwuTknSlVWIc3dlAcZ2lZFDrwQbS92Zm5EGw4AscoT/LQogDwev/hBz9AZeflsTDWgr1tmQ7xQVemvQzabGJn+cqVscY0z8jXuBENIxzDKijn5In4amjueyzN79LzRZ+3ySWpKCZeAs+oHIrSVcjtWg7ctwa3M5m7qch5unLh1/iVFpt11rSrSf9HDz7feMyQvDOqNAlUVPL4HWUaCWnn8o1nAY1G7sZ7/pnK+iYQzpfPRZ0HyigMgFKEui01kvBdgXSFaQ9BJrhxVgIShmBSy4/JrFU8/WM4oua9CiGsd0maceubeuQff6ugiLHlasMDCArUvj9UVvt3El2qgqDwF5cjC/UXC9pWrYh9TotU/attSFvTaQV35pUCbsHrZnflbYZimiUt6FFX1w/e2N/Oc9Xg9x/SSS/jBDO1eVjL3lCeffcevnMKvqLhNDXfFEY+3z4DqB4zhXx6t3mxwO48x1mukf1ooqCFwm+tM86XB0UlwW1s0bwiaIsVtdzvqh6aTXt0dMv+ghNHbt8nHSihd6c2cMBXP7ExSrnbX/eYW5xUrE7UDfC/6uQz29RQN1MaN2stcmRw7REdfLUHjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6c68ff-f767-4a97-33e1-08de1d459a2b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:03:11.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrsfvruGpRYzMSvk6EevECrAWGsIgaqnYHzpQ2ewhY60oTUuK5V8WcYrdaIlFSKpX2RuTbMU5vhtKQYVFAgw/uuXpobCVi7YXvNC7WrsepY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEyMyBTYWx0ZWRfXxsAX5RCd3B0K
 joxlrFeEjp+vXeH+jKZ4wDSb8m12wnmlRz7PfKrDXjzgszpOzvwR+rrU2z2+uW0UDkZaFSCEtcU
 eqs9tpqof2W1qt0zSUuJfjX87fkH1LvtdA9uc6Ws0nwGew6Qk74e/oBP922Du3i29mDoJSCiTnK
 LLUfE9+ilnd0U2QdZPJgtQa23GszbBzzG6tFpiatLmA64H82AdJzD9A14WEWpGD1rWXywK7oDeY
 UWeyVADEVnaRUz3NOdqPZvuPprw3gJ72+x7EvWRNeJdQLHNJbHsBEzPb+BOuEruoalrbvtPLpsx
 2TiXc+p5llNilH8cmCRIjiAWQV0FWyJvSSg1QtJ11skGGMq9lHiHYJX3wJbX6QpbE+xdA1XnWeO
 JF8VUfoj5Q9y9ra0MbxjPwj0TSnmEQ==
X-Proofpoint-ORIG-GUID: rbvcI_Cv0p-T_X3EBRmoh2kxiQuYlw5E
X-Proofpoint-GUID: rbvcI_Cv0p-T_X3EBRmoh2kxiQuYlw5E
X-Authority-Analysis: v=2.4 cv=PcPyRyhd c=1 sm=1 tr=0 ts=690cb8b5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ZlKvLt9NEAVkraWw6nIA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22

On Thu, Nov 06, 2025 at 02:45:06PM +0000, Pedro Falcato wrote:
> On Thu, Nov 06, 2025 at 10:46:13AM +0000, Lorenzo Stoakes wrote:
> > This patch adds the ability to atomically set VMA flags with only the mmap
> > read/VMA read lock held.
> >
> > As this could be hugely problematic for VMA flags in general given that all
> > other accesses are non-atomic and serialised by the mmap/VMA locks, we
> > implement this with a strict allow-list - that is, only designated flags
> > are allowed to do this.
> >
> > We make VM_MAYBE_GUARD one of these flags, and then set it under the mmap
> > read flag upon guard region installation.
> >
> > The places where this flag is used currently and matter are:
> >
> > * VMA merge - performed under mmap/VMA write lock, therefore excluding
> >   racing writes.
> >
> > * /proc/$pid/smaps - can race the write, however this isn't meaningful as
> >   the flag write is performed at the point of the guard region being
> >   established, and thus an smaps reader can't reasonably expect to avoid
> >   races. Due to atomicity, a reader will observe either the flag being set
> >   or not. Therefore consistency will be maintained.
> >
> > In all other cases the flag being set is irrelevant and atomicity
> > guarantees other flags will be read correctly.
>
> Probably important to write down that the only reason why this doesn't make
> KCSAN have a small stroke is that we are only changing one bit. i.e we can
> only have one bit of atomic flags before annotating every reader.
>
> (Source: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kcsan/permissive.h#n51)

That seems a bit specific and technical though? I guess since Vlasta is asking
for maximum commit message pedantry here the more the merrier...

>
> > We additionally update madvise_guard_install() to ensure that
> > anon_vma_prepare() is set for anonymous VMAs to maintain consistency with
> > the assumption that any anonymous VMA with page tables will have an
> > anon_vma set, and any with an anon_vma unset will not have page tables
> > established.
>
> Isn't that what we already had? Or do you mean "*only* set for anonymous VMAs"?

Yes... I'm going to expand on this explanation as per Vlasta to make it
extremely clear anyway.

>
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> With the nits below and above addressed:
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks, though I disagree with nit below.

>
> > ---
> >  include/linux/mm.h | 23 +++++++++++++++++++++++
> >  mm/madvise.c       | 22 ++++++++++++++--------
> >  2 files changed, 37 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 2a5516bff75a..2ea65c646212 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -518,6 +518,9 @@ extern unsigned int kobjsize(const void *objp);
> >  /* This mask represents all the VMA flag bits used by mlock */
> >  #define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
> >
> > +/* These flags can be updated atomically via VMA/mmap read lock. */
> > +#define VM_ATOMIC_SET_ALLOWED VM_MAYBE_GUARD
> > +
> >  /* Arch-specific flags to clear when updating VM flags on protection change */
> >  #ifndef VM_ARCH_CLEAR
> >  # define VM_ARCH_CLEAR	VM_NONE
> > @@ -860,6 +863,26 @@ static inline void vm_flags_mod(struct vm_area_struct *vma,
> >  	__vm_flags_mod(vma, set, clear);
> >  }
> >
> > +/*
> > + * Set VMA flag atomically. Requires only VMA/mmap read lock. Only specific
> > + * valid flags are allowed to do this.
> > + */
> > +static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
> > +				       int bit)
> > +{
> > +	const vm_flags_t mask = BIT(bit);
> > +
> > +	/* mmap read lock/VMA read lock must be held. */
> > +	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
> > +		vma_assert_locked(vma);
> > +
> > +	/* Only specific flags are permitted */
> > +	if (WARN_ON_ONCE(!(mask & VM_ATOMIC_SET_ALLOWED)))
> > +		return;
>
> VM_WARN_ON_ONCE?

No, this was on puurpose - I don't want drivers (incl. out of tree) abusing this
so I think this should be runtime and explicitly clear. See Suren's comment on
last revision of series.

Obviously we should never be giving drivers naked vma pointers where this
matters (and actually not sure exactly where it would), my mmap_prepare series
is working to mitigate this though it's in a situation where the locking doesn't
matter.

Also you can't use VM_WARN_ON_ONCE() that way, for some reason we don't have it
return a value, go figure.

>
> --
> Pedro

Thanks, Lorenzo

