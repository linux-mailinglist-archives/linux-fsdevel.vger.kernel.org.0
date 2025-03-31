Return-Path: <linux-fsdevel+bounces-45333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DDAA764F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 13:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1DF3AA8FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E745E1E1E14;
	Mon, 31 Mar 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KN9YuehZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O7uqirNb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A213A265;
	Mon, 31 Mar 2025 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743420467; cv=fail; b=a7dspDxsxMoEL0V+tJLu95RlJCguBBGYQ5TrQZTwsXOmAUVPySZ/BfNrw40RCvYQHZ4GYzxnSgPXn0cuM5ELT/I2lQM2weVFWg6mWF9sRnnDOcnAVSaxbEok8Yzgd1FsSI4xIGLn2SAl35i5oao5ZRJhh+gk1KPXc7hbDjijYsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743420467; c=relaxed/simple;
	bh=8r0sJE9FEwsHwbguF87ZyLlKKRrabcclDjLRbgOlsXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bWez6MNsRGKorgeBzC9eEvUrbSg3/I20PyAotvasY+5d950iUPoog4HuJ4MVmL0yH5K2ZCgb5G3cS7VPgDZjj5NVqIYF3xIeuS7lxL7UP23FlxzpBBH2bypSzfeq+1o9UwgZFfi99lxLln1JT//7IMDE9JfB/5px9JPCC+i6e/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KN9YuehZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O7uqirNb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UMeW6a011404;
	Mon, 31 Mar 2025 11:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=0fan+fp1oTcoHHsD4u
	WPDhRBlcARr8ijlLF0fWqVies=; b=KN9YuehZkCP0cRwrt0aG4tCy4MdBrnjDXC
	8a/QFFG+8J26h2bUtjG1Br65llTTQ2EL7XHL9/6xURuMyrnIAf0XFWwDwhubxObC
	ljvIOciDWYfEAQezbsSPuOYUdJipUf7FKUWjpThSapWYdF7AMWE5by3YjMwYCbtP
	QVXo7Z8oSPWhel3mnwuswKjte7woNXqOrycqBQLivKlYG+gCebGhAk8E9sO6teDw
	DeDbH7JftJbtTTtYH8TbcDwkMXbnn2cqMKyCqTeU/E2+WA56Eg6LQcE7+ze+8tKp
	0cRn3E4jxwlvypN1mfBBj5f8n3Wsxr9Rxjkf0OCv8qY6tpC/qrMw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7f0b0td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 11:27:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52VAVu5Q002715;
	Mon, 31 Mar 2025 11:27:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45pr8nqk4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 11:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spD7S+Htlb4ipN0FqxGNLWh2Po6coim8VOckNd7iI+y1/U5gsOBPa8AQ7E9hcqftv5JQsp5pXx4lYLjmdEBROZPnyaFwqyp8oGWI117/xIeZmz1GpEaIY1a0CdKfQKUxj/mzt0KSn0Qur3AfklrTXQpE+mcIZF5GiaK/SuIgVWku5/rPF9N66SnEoGLNgdU+2vxhTl+J464rSZcPoVhxj2oYrT9UvCNgSUyFfdzev2HruJWBS8aJgpexo0LPdb/1YAsBxpPABB9O6OueAINMrVEArG4GajDCT+y2bZqzH4ebNigXCeebcDiNtAWWHnx6PaML2B4WEZcGYQMBZphddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fan+fp1oTcoHHsD4uWPDhRBlcARr8ijlLF0fWqVies=;
 b=pUOim4y34w5u6pnmNncU0z9dzoCGoCjEDgKIFQEaH5t7cMr59h5pu6FIsAhu6Rz3dW/XMpopfVqUXBVY9cQLsi0Mdsp2gB8nZQdzr/8cieXQabBAXpEG0DmQ+QfpEhLAoNhoDFxziB0wrJwgCVHQ2gCOdXrz3YBeutN4mahYO9G0FUdyPqLjNBKcKsK+BzwU13gURm+idhmAJ3v65f3WfKu9IfGGnFo7DdyG+h1F8VQnzSIWOYgF0bsDOCBJ/wcILqaq9a55Ib9tWLMm6QBFQgNRNycFQPi2ThV+dGjeedUNHHgELrV8Gj72/D4HHSNzhU8BP9LzUSQZI0HUa6bm0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fan+fp1oTcoHHsD4uWPDhRBlcARr8ijlLF0fWqVies=;
 b=O7uqirNbjgLQ4IjtBjqihfmsSoZbK12jSL6gYRGPMt+ZjuYfUCYqOG4QS4JFTQGF1rV9iw2V2U+L3aypkv7DIrVCoVqtM9DpmjT8PxtepWQ4ULoSU/KIHM/egjN42Ekn1g6cF7g/bEJVpfGsu7hkGN4lS43Ia0aygc5jl5dPM2w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4180.namprd10.prod.outlook.com (2603:10b6:a03:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.37; Mon, 31 Mar
 2025 11:27:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 11:27:29 +0000
Date: Mon, 31 Mar 2025 12:27:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        criu@lists.linux.dev, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 3/3] selftests/mm: add PAGEMAP_SCAN guard region test
Message-ID: <52bbf098-46df-4227-8429-befd1e250b17@lucifer.local>
References: <20250324065328.107678-1-avagin@google.com>
 <20250324065328.107678-4-avagin@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324065328.107678-4-avagin@google.com>
X-ClientProxiedBy: LO4P123CA0210.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a0a612-c1c5-40b1-5bf4-08dd7047053f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?muV019BC7p1OCTKFbARVEX3Ab3Hk4Lli8065JfQONlLuqI4j289uwLqyWNWC?=
 =?us-ascii?Q?KpQaiezONF7vC/QsZa/9XbyBjtzM8rvURmocps3d4x61yYgpH41gttWpI6SG?=
 =?us-ascii?Q?KwshKJqlTyyvEDb+ICUaIbVcoJ29senQgjsOxtu4RW2onSQKiLDDWLwoj7dO?=
 =?us-ascii?Q?Uw+KJJsQnNs07XglGk4IM7z1MD5HIknId1zyLIYrVwljoOed7Jdp3S1fZ5fH?=
 =?us-ascii?Q?09QYU5/5ADW6uVcA5XUGgqKEplc+R7up/eFTecNpAwLAcpelT2D6V+B9pKGQ?=
 =?us-ascii?Q?JydKz5ZPcVk3qrwHfamyPYC2pE3RsjwXQeklcbtI7odu36ALe6xNtlM6x2ug?=
 =?us-ascii?Q?NkWWwtWCuMP/aKfiQ971Or6dAJng0hDnAFOQfGa7JzZMbyWpuIc5VUGil1n8?=
 =?us-ascii?Q?YcVmZ+ysgx6hG89rUeZqeoIamIZ0m/OTmqzQR23/lPmuP1mr9guG5OGbzR9s?=
 =?us-ascii?Q?WPb46B4Nk86nPVb5dA4sxksp2YVYyzBOB4NTDmvmdf8QiHs/VI8OGmOWTWLb?=
 =?us-ascii?Q?Gg+nUzrsPFhBCt8T9nBYgIcCyeYyIk/ivusVL/V3oake3TS+f263ti3/ta1t?=
 =?us-ascii?Q?p9vPObzUEiNyfYXHPH9jk5Al5JdWvW81nnnxTDg2NwdTZu1V/ZSV6zNTrqv4?=
 =?us-ascii?Q?CNU+byLO4z5BVmdag4yjZexYZ5JwomJ9yze7caKhaJo+2btL5PTUM1GZ8hvQ?=
 =?us-ascii?Q?lOsJa9hA/UsZFKpq1DPXillmXyEwy5buDsJtWORhSzwCvLId9SxBIx/PqJ7Z?=
 =?us-ascii?Q?8FsjMzIlwLzSbXG3RcALEXolIjVwlO3ByzmJjIGRXk7DePkleYlCiEL5fGBI?=
 =?us-ascii?Q?CN01HHGwvVOIZR3rQC3gyLH4Ns3hP1ONTFWy6sPbg25FleuYAZ478cvRHfsO?=
 =?us-ascii?Q?In3gy4g2L1GvJ0ts4+Jp5jSWLuYE0ppmYZQmIzdfS2uQJ8ggFSZ5DYhQJsk5?=
 =?us-ascii?Q?cMxfUlKIKsDCq6pgXq+3a12Ygdx4E7Sk65s2vOKmoCxJN+sOcs+DBFVnfCHA?=
 =?us-ascii?Q?arZkmZUByZomySKEZKVRl7YQhR6fvZoGDfcVfd11IEUG4b3fZUOqejVLyl04?=
 =?us-ascii?Q?Nk/oVf0FKbZoQUqaLLP5gvdeU1bVZroKeaasvTiVwbdtR5mtb633pfQb35RE?=
 =?us-ascii?Q?mCi8tTVX4hx/iKatkAXYAbszoj2fKRdLr29h7Svzqj+zuTjKDAjEpGP/zvEe?=
 =?us-ascii?Q?FgvaIba1BBZG/bUqE6GRMILQKQZZ+x3ZR+IeibLxSPN0is0rqyTsgoa8dPLF?=
 =?us-ascii?Q?G7YOwxkY8glCtyYHkEkvhVi32DTJj3NXVAwiEIDJoP3pq6htTFJ0KFv4OAgc?=
 =?us-ascii?Q?rAlPthIUnpfgXZyLUg5vc6NBF2ApUuQFtfLd2Q5Jvz0ZiwpYeT9jcFoz8USO?=
 =?us-ascii?Q?PpmQ6+TzgIRjdl3eayNfNsGVttfM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fu4VGY6WbZMQqV3iD6WcunJ98pNHN0nhKupANHSy/woHZassErIsLQqxT7EC?=
 =?us-ascii?Q?GHTYcH2QlyiL+1hAE7aSQHzETXLRa2f6iMqZKWxjwO7/58A2jtNZat+A+Oep?=
 =?us-ascii?Q?xWHsf4XmJWyILejJfj7leplMmDhI85lhkMIoEp+WHpIzl/k6c+ZQgquNzVJI?=
 =?us-ascii?Q?8d9poX6jG/drGDUn7DVq6oNru6NMrLbNQ7zFTjv7uhj2uGeZ3sfd4iaZqEtB?=
 =?us-ascii?Q?WzJ4G2LFuX5AY3xVPLc4G7we1l8dgepjnSz0kVdH5r1w6uwlLjKM12D3Chvj?=
 =?us-ascii?Q?pizTrOb3+Ndv2rs6YLQT/7xLtuY/6AmX9o6m1yjeV5IXLdNLQLniG9V1uZQq?=
 =?us-ascii?Q?MS4+HU3pzjKPYezo288ggqQ4uA6d32OVvXI7feOW2tWTp7/0AYvN+fKbEu5C?=
 =?us-ascii?Q?GSMxY2+YQ9xCIfx5QSeh60rL3RXBvowwIt2WfaQJFyCtRgG5bwyruWmPTVc/?=
 =?us-ascii?Q?dJt/L0+CIN1ZG+EyDb02zcvO1yIroVqwvTLmwt4+Xnb7Ri4wWP5j50WrSvxt?=
 =?us-ascii?Q?kZmGkjsoBdYJglO27tj9EmVbWk3bNbSRQ7eibHi83PdRUfjuRjIkA2QlyNgz?=
 =?us-ascii?Q?6T++HBoVJ+UHlM4E3SUeHijG85CUBhtrPmo+SrbE/IUaEDpDXRO/T3l8XJkf?=
 =?us-ascii?Q?/d8AXBstcK1NQZuYhShdghxk2+SaXXZqOUy1iX4bBkGVsgW3wmPf+JGD93ro?=
 =?us-ascii?Q?7fqcJzANF99EzHmqieaPQUqARlHoxCg3TGbo5XF8M76z9bjdVsnLZK89IEu2?=
 =?us-ascii?Q?sHJv4o6B3L7QYAhlJjMUgC7QHOD5UV9BhkVn84U3nd6ai8q8ebzu2+diDOt1?=
 =?us-ascii?Q?Fi7mwv2L/56iRpnvBaoJPdqb4fwoCk1FCiM2iGch+R7NN/1zFyoYXtHVw3Qe?=
 =?us-ascii?Q?y7EUtLAJRYN1XGqCOBr5SRSziIM3oqHGSkLZ+O5wW2xRFUHkXC3tVwoh5jah?=
 =?us-ascii?Q?hOcSn8aeozP6J1Wpw5lIBC11SWakwbR3Qurt8WsyD9ZJMjNEkB5QfXZhacH/?=
 =?us-ascii?Q?m4Zr/QeqncpDHGzfvQNLClt07yB9Km9Bp/43/3PHx+MOjjZV4ID66qPQMRXF?=
 =?us-ascii?Q?G9A//hfWnXk/iCXCv1sjYON12aJf9bg94NRr1J02Vv3vxHSPwPsMvelgGgqG?=
 =?us-ascii?Q?ewiDmZJd8PmOXelISDWNE7iicWzMzVT/BSGxUS/fOy94/Nz1UaH5bZzx/eZI?=
 =?us-ascii?Q?04HxReun9UYjmw8ZctC+hBbx0kVpwCZmI6jVuDbOaPgt18GYzYRrNfl3UJdD?=
 =?us-ascii?Q?iAxZGomxNykeYIpKLlsSBSy+vWwRCpUiIcAN3DnFr+oey7L0EYcVddiGPg0t?=
 =?us-ascii?Q?euHzGs0SNIPU4E8PhczUHFZZTb5F54g6ESm++qaDd8qt+yGIerLP7Gmkh7mb?=
 =?us-ascii?Q?XOsH0Z78WMbMOEd1D4tavm/y3dWdhakha2PY3NOSTzElcTZebyfJhSTH5wq4?=
 =?us-ascii?Q?MvRgxKp+spv7PDuntUXtTSFF+47j5xCnGzhXoY24SRfKAwU7cvfDFf08e3kc?=
 =?us-ascii?Q?8PxxnRj283Yv5VYBicA+rDEVDxcNoLccPV2l2khEajEAvv4in3PAJaLbCKxl?=
 =?us-ascii?Q?khZ9HIeS+A790Yl3wivqdiv4MdRdoM0xXQXMIHxiHDN6nwq4c+uY+W7fGfLs?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8eh+9A+wJOogFP3OGakTw5bWfmfz7pkHGdsOW0iAgaBQuLhVDvAqyj3Hll3r/i6P+85yWuFxnTDo1Z6Rp/Iwpk9s7v4kuOja8EOiHv2Z362nuKsA/6loCSzbzw/uzGkqCUQp09ANcuXnhyNG8YRCJrUhKyKluwyfQM2VR3LWt2CkHASbtKd/GIKcyyv8l47FVG5frC+h2wZE9wnpHWoOqQ0rVvNEz24BVVwTm2rfDiPaiixeiuW+YPqccAcArmxLg+xWojgJtEX09aqPZ4a7XpUIDn13hu3Y0fa1vN+FqYpXA6/Af3HvvoaJSkOhcq2mCM8h7dWkeS0JGBeycyHHK2NrQPPMWfsVHAem3XcQeZxRYMeB3mX0StSHmCS3NNySUmM83RwZc7aqVq0lk3VJQ9wVVtgriiR1bQyzwDb9lMcurOjUPdtyeAIlu4ve+ElrHAcvqgNbdN/Q/Tw2hEQQWLPS9lmx2tOdmb5UtrEASANQjMac4LJhgsXpS8/dULddT3K/yR416WRWvm1+Csww+UwtB3dkhEK9EHSHXaytSMJXCDR7/BYQ8J2z9E31ciXYTqhxhgnaWRHWZ9MUqMl/1iNJ7T71wWWzPhvxfDHMNv8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a0a612-c1c5-40b1-5bf4-08dd7047053f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:27:29.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUkn2FJdMWjC5NIzwhgzgFMoXrfK/AzoH0CHBCfvz1rdGrVb9z1/6vv1AEqXUWdHsDqf4czoxVv7kH7cnds081Gx6FZqUOkp+yr7FhWxGuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503310081
X-Proofpoint-ORIG-GUID: Dyc2lBNVkF8WEczTqpmDuuRDU7usqqXu
X-Proofpoint-GUID: Dyc2lBNVkF8WEczTqpmDuuRDU7usqqXu

On Mon, Mar 24, 2025 at 06:53:28AM +0000, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>
>
> Add a selftest to verify the PAGEMAP_SCAN ioctl correctly reports guard
> regions using the newly introduced PAGE_IS_GUARD flag.
>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/mm/guard-regions.c | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
> index 0c7183e8b661..c99f3da8bfb7 100644
> --- a/tools/testing/selftests/mm/guard-regions.c
> +++ b/tools/testing/selftests/mm/guard-regions.c
> @@ -8,6 +8,7 @@
>  #include <fcntl.h>
>  #include <linux/limits.h>
>  #include <linux/userfaultfd.h>
> +#include <linux/fs.h>
>  #include <setjmp.h>
>  #include <signal.h>
>  #include <stdbool.h>
> @@ -2079,4 +2080,60 @@ TEST_F(guard_regions, pagemap)
>  	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
>  }
>
> +/*
> + * Assert that PAGEMAP_SCAN correctly reports guard region ranges.
> + */
> +TEST_F(guard_regions, pagemap_scan)
> +{
> +	const unsigned long page_size = self->page_size;
> +	struct page_region pm_regs[10];
> +	struct pm_scan_arg pm_scan_args = {
> +		.size = sizeof(struct pm_scan_arg),
> +		.category_anyof_mask = PAGE_IS_GUARD,
> +		.return_mask = PAGE_IS_GUARD,
> +		.vec = (long)&pm_regs,
> +		.vec_len = ARRAY_SIZE(pm_regs),
> +	};
> +	int proc_fd, i;
> +	char *ptr;
> +
> +	proc_fd = open("/proc/self/pagemap", O_RDONLY);
> +	ASSERT_NE(proc_fd, -1);
> +
> +	ptr = mmap_(self, variant, NULL, 10 * page_size,
> +		    PROT_READ | PROT_WRITE, 0, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	pm_scan_args.start = (long)ptr;
> +	pm_scan_args.end = (long)ptr + 10 * page_size;
> +	ASSERT_EQ(ioctl(proc_fd, PAGEMAP_SCAN, &pm_scan_args), 0);
> +	ASSERT_EQ(pm_scan_args.walk_end, (long)ptr + 10 * page_size);
> +
> +	/* Install a guard region in every other page. */
> +	for (i = 0; i < 10; i += 2) {
> +		char *ptr_p = &ptr[i * page_size];
> +
> +		ASSERT_EQ(syscall(__NR_madvise, ptr_p, page_size, MADV_GUARD_INSTALL), 0);
> +	}
> +
> +	/*
> +	 * Assert ioctl() returns the count of located regions, where each
> +	 * region spans every other page within the range of 10 pages.
> +	 */
> +	ASSERT_EQ(ioctl(proc_fd, PAGEMAP_SCAN, &pm_scan_args), 5);
> +	ASSERT_EQ(pm_scan_args.walk_end, (long)ptr + 10 * page_size);
> +
> +	/* Re-read from pagemap, and assert guard regions are detected. */
> +	for (i = 0; i < 5; i++) {
> +		long ptr_p = (long)&ptr[2 * i * page_size];
> +
> +		ASSERT_EQ(pm_regs[i].start, ptr_p);
> +		ASSERT_EQ(pm_regs[i].end, ptr_p + page_size);
> +		ASSERT_EQ(pm_regs[i].categories, PAGE_IS_GUARD);
> +	}
> +
> +	ASSERT_EQ(close(proc_fd), 0);
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.49.0.395.g12beb8f557-goog
>

