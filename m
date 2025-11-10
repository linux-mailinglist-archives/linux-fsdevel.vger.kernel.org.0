Return-Path: <linux-fsdevel+bounces-67731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ABDC48618
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 18:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C830A188B198
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF97F2D94BB;
	Mon, 10 Nov 2025 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fg0QLyHT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nfdtNBiS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218EA28F948;
	Mon, 10 Nov 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796267; cv=fail; b=jvvHYjWSgDEYUgiCOalKkUAE+5CEsR6pdjsmIDUj/tLYtcp4kkW6jRFzdK6mUV1KueXEXHLK249GZmzH1axFV3v24G1ObF9jxtxM0/gSdxJDtA0bUOlvD7xlWLFiJ1iWJ6juMxuHf2XWxxHeK0QHFQf04Z9f0YHmri6hT5lhV8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796267; c=relaxed/simple;
	bh=i6MFIbBMx4DtXjgWAnddb9k8VyNdSGVK9eaQ6pjuloI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PNzUTArX+deygQiOFBFecOjaGyOvbfUsh4LwTyekehbA/ii6zo2KbYx5bn8rysTL49jvVQGbCn/5OutwFYMJHAw8f+8RJ7OTO0BfMtHSi4Z9Rn+Qeb68rwg/ahRbp2cjHz1tDWODOVN8NFpLRfj7ZRdLAEDvQ4Ak54jmJdfJM0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fg0QLyHT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nfdtNBiS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAHWCOm026646;
	Mon, 10 Nov 2025 17:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wSHoJqIhOhKn7Oh8n7
	hnedOraDqe6ZZG6/EuVPsiyNY=; b=fg0QLyHTfZwp+EAFrhOkzOGneo/Q4bcG3R
	UCXorKJHgDlN9s2u6/95dNS24XwKBT0Znh6eTZQ6TBMwScpHd40Y034H2RzehnEo
	vRytkqX6L/s3BB2phefp3gAuenCBryEySa+FO83Wqi8Cg/z7Kcu6GDAvVOgVmS5x
	sgMcDmkdWgP+05jjaub/YrSf8LRU+ZQDUo605jcUC2AgFyTX6+a/Q5jafGeS3ukY
	LmOkxJVCfm9D4ikc6BaQLx2N4oJ5FacTgiSNjl2zx2RtYQiIN8oviCk1tzEPrXMK
	vnWXnFHKxNsCZHrBv0qd2Iv47JOgOmPBVpl7+dfBcPQ+bb/2Jm9Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abm9ng1r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:37:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAG4lnx010112;
	Mon, 10 Nov 2025 17:37:16 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaj7a39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:37:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHOChkzS+xezJ4vVZ3v58/0eSkvMgTY5HN/1e04s9ozZvzAzfUPMbB9xLPK9N3c4CZLxaX6q3lo5R9z4zRU/gnnbo+XLP7hsywQMJDchxzUEjSOVecznZ72QFBd/QNuVV0hw42pYa0EwZrUCe2OTud96sBknUi5KXWPXpGDEKu0K3zuGB0JxrYrMsq4mfED3k+Qritsc0F0XRnHCZifUtqt+pQgAuA6hnp/YkvOP7KO6CLgBjyThcseO9+KDkwYJer34LG6YlaNSs28TKmg9XdxTkL6v/wqdPy/6xb+gDedCd9lS9B8laPTcWNm4NNH7hFKWRbcO3MxKVdi3ZKgCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSHoJqIhOhKn7Oh8n7hnedOraDqe6ZZG6/EuVPsiyNY=;
 b=axGaVZatsKp8iEuFJWkgtwCEGiG5zxQDhCp//Ef49rI+tBiiC3LCeFYFBR7JZu9ahi0YXW+SS7MLv2IHXCKWw83T0Sx9MYIaVvaF0C1j/z/VuOs8Q3qeDBrPottrNFAdFqwffbbGULj3DLJ8DS2oJOOUGnWOmKJll4ky5i2MUiMV72rK0LmsixJkvExvLclDmyCLAcHfWZ4MbgJ2LnckWlvpCIiE3QD6Clk5D04MPFRQDBHQNLezGcMn8OJYCWGoIbCYtenbAtiOQflG72ZHSTfrU2W/z8SUs3mcxTmiDaH7ksSJh6wFbe1YalCDMCfYFlyiGIFpbNMBF5+p8jhJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSHoJqIhOhKn7Oh8n7hnedOraDqe6ZZG6/EuVPsiyNY=;
 b=nfdtNBiSGzk0O1AmOwIjMDyIULRgB9e+15Z8wZXfG1XbYKTvKDu9/f0hASDw5m0xuwPUA3Dxw49xcSekHLy4jocGVVt6GKpJ+BVV1RYmyhITgk3GFv8f8qN65v0Uj7Okl7x0UdK80GE5WjQexfsSyjREdlSaKU38Qk9esAwzrlU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4474.namprd10.prod.outlook.com (2603:10b6:806:11b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:37:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 17:37:11 +0000
Date: Mon, 10 Nov 2025 17:37:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 5/8] mm: set the VM_MAYBE_GUARD flag on guard region
 install
Message-ID: <b0ef1d33-12a1-4b95-93e6-33ec1b6e68f2@lucifer.local>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <99ce6131e27592c92b43ac866da48b4c2a568298.1762531708.git.lorenzo.stoakes@oracle.com>
 <2bbccc79-d64e-4ace-a528-37295e3f8a4d@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bbccc79-d64e-4ace-a528-37295e3f8a4d@suse.cz>
X-ClientProxiedBy: LO4P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed91799-3b8b-4605-eb71-08de207fc7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/PtCx8LwfhHLUMYPwCUJxsOGyZhqlDlhSyHnIpmIztoVsJOEG9xM0PJ7Aptf?=
 =?us-ascii?Q?RychFOtSkmRjdfOYxJRRw+pSLGnqoVMlO5cOWGOaJo20vyb2DIyPoS0W7JwN?=
 =?us-ascii?Q?Tdc2MQoKeWjwTdiYpffcwZtMKDDDVqjsaxP0O/YtQRbmdB2NzUrLsFfVXemy?=
 =?us-ascii?Q?i2fG02UazglX58I3X6oA1NAwc/E5afMlZ5gpK5OyazBCdOpONBb7qJXHsM6t?=
 =?us-ascii?Q?a0UC6onyB6N1rqR1R19bu/DHeVxLy3uCbIVKukGJ9MyWZMWTlyjVMN5BWxst?=
 =?us-ascii?Q?hLYkJfhK68cxpCPdmLpZ7fGDUCwvktWyvYKSCApSkZxuFwIucftIWUm7aQ5T?=
 =?us-ascii?Q?fru2rofBE2jVtSqg3QKgBqsUysnOCMP4eqnjaZT55a+/3r75zXmn5sNZ5b5K?=
 =?us-ascii?Q?7pLPWLeXOv5WzK9xmzJdLV47WXdnlhk4ihShxM1b8UVCslV1wmTnrAgXM70u?=
 =?us-ascii?Q?0kGkD5f8aLqiS0gRGEKYlqbILG5jyYRTJLJuJMV8OkEasqOQNm5ockCBq/9K?=
 =?us-ascii?Q?9PzHaT7O4Kq4zv01zmzylZmjTZAlbQAQLoX8GtUOEnceUMgn+uTmd5PwE3yN?=
 =?us-ascii?Q?q+9Ocf1g3aEbhmMmjxJZ+bIToAtX0m9RZDO+OPM9N76e5Uvhv2lxOSPr3+Tp?=
 =?us-ascii?Q?3FfPdWwUaZgpQpNIZAqG+vZqFhisPkN6rQ0bySh5wm+YQ8h1ceNUklYZ+4Yy?=
 =?us-ascii?Q?mM3JX9pKOUuBBtyJ7BuhfmUom8I4wKb0Ve4MYgEmxoUr0eUcxLaYrQFwvgbO?=
 =?us-ascii?Q?d0+SKXZtOwQvwzDKTfRNVHjkXpps804NSkK1CRnHT0wu7c5CHNCyAG6fgZb7?=
 =?us-ascii?Q?d7pBUyx4zvK6F+M7FRenQYLtltarX8nUFgruj+ERXgHdlpOGZ4dyZQfdrjSR?=
 =?us-ascii?Q?hQ6DenBG/RBegwUEcWYKzBEDTKPZ6Se4BjvfrGu9qq10xzFqc9ttkh9yKB7L?=
 =?us-ascii?Q?TKv1L4PhxhREQDLIkELgd568l0GWaoKkNoxRUbvA2ctErToFCt+Nr6PN3CH1?=
 =?us-ascii?Q?92QOFr0Pr50RHeTVwOG9sDmcfCZUK8wQGCOe+IBJLqUK2p58gXd/8ustkpxr?=
 =?us-ascii?Q?LWLLwBtEAVH3vi12iLhpU6JXd+2lWuTTticV81OdmW2dMPUb3YLjA4l7yoIS?=
 =?us-ascii?Q?B11Tz4lxOv2br0mWohpUAu0jFFFFrdpzCBAzj/o+9rlf5aZ7p8lhZwW59C97?=
 =?us-ascii?Q?no8R7gmNr334TgjJJSUAZkkarTipf0mP3rzAt2ctH0U4ZSD/lWR6TsjvW91B?=
 =?us-ascii?Q?N+Jahj0U5CkTOA/Zu7HHk0sl4Ka5YknYbK/TLET/6jKglQXMEWdJgfJxh3Kd?=
 =?us-ascii?Q?g8jbbdwMiGhDpu4Qm6f+8Nw1wYUtNNtToEA/09R9vqv3aRzwXPUIT8NWIZFk?=
 =?us-ascii?Q?CGJVS+bt02RAikNsQ5vjp1/bxvh/RdbGH9FowVRQhbfUnUrspcgJziK7xcXH?=
 =?us-ascii?Q?PrY4bg2Rb0airscQC7YbxqR8OV5yDYDR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9NOAAGBohqkWfhss8Wwu2lr6ijiFrp6EayMHDG8pLu3LZBtOYkimuai7I1H1?=
 =?us-ascii?Q?+91rtExpqOASXSVI96lGfK5EwY7pT8JAq5b5+/G1yeCVV+t32ybyhmWPSxnj?=
 =?us-ascii?Q?3uzdFoBYwCXRAOpfBBrMc0GjoaqIlvkNdPcFTJ485wzczG3akFD1TMcNBWd6?=
 =?us-ascii?Q?GtFUUsG3MD50zuowbFxbWUL07ireSYKtjFcaFYuxsXbf83LA4JBLRc7El/FT?=
 =?us-ascii?Q?Q0XhwsnfNfim0xmmfNLOEiq42AFmUEEgp6rX1c80AQC3939m2LWZ8iiiJ3pf?=
 =?us-ascii?Q?WqeBj4FHqXwP97crARB9x6Thz1/Rjpc4Jkook3fbNnBxKPCeJrTIxtfzQfv/?=
 =?us-ascii?Q?t+oVEPRd/ge1loXMNqUmwQROfDmgB+wU2UuWIdHxZ+z6kihkQ7swK6ixyrKW?=
 =?us-ascii?Q?AKRw3GUIMpzaOGeV6dxAmQV9ulzdMvIfrqzDiv6dS/cwr3yYunQxFe/ybajZ?=
 =?us-ascii?Q?g3DCwpo4I1anoGWGgTP6ow7j2Rrmp6ag5nQCpdmiBCUyzX9hOg3sjbgNZhpx?=
 =?us-ascii?Q?pKQjijG6TE/L4Xd41IVSTtdYIgZcVb69L6xJA+4vC/kEkDNBbZlgHAQszZPn?=
 =?us-ascii?Q?YOe7Aoz5oSs86OtNc3Cm61X0TKgKBIs5qdSIUa66rBCQyUTycRrp77G0QxMh?=
 =?us-ascii?Q?Uhyz6sI69Rkcl4vccc6g+qfapkZvbq3VfKgTc2n/oIltQY4QqhTslQlFUVRx?=
 =?us-ascii?Q?a3vYhZolzkaoaJlTTYFHFN8xhvgPtrMko1Kzf035A9mX6AqSJ2eru/hY2bh4?=
 =?us-ascii?Q?LuUwNSYk53TpaoUjNtmAiq0qvjl2Lf4qLyBuZp4LtO+GcHVbMA/5XODCgwrn?=
 =?us-ascii?Q?0Z3HYX8iYVzxb3M4cg4chd7XSACiqnaQf9xMdrzLXKxs/0jx/ohu1Ht6lsPq?=
 =?us-ascii?Q?DTX2lDUC/7FAilLdUkyyBi2cvJFegao5pnErd4p3EZ8ClZF206oSSPk5Fgqw?=
 =?us-ascii?Q?Hj91giifIB4DRSlkfJwQ+AUls5JXgrcnqKqI59d3Dosl+HBHjNy3x/hGs8oU?=
 =?us-ascii?Q?MqwqNt6O7hBd81CvsWPJCx2W7dT7pCe/UBNGcPi8oUUGSD0Z+s0jHH5bAWg3?=
 =?us-ascii?Q?14tYMHo/VUdFiixYxb9rQDvPtlp9z1rIMBX8xOZXaUQZ5pwblBpZJz6w5Rwr?=
 =?us-ascii?Q?wKI5gck2y814fkUQ+l+ynY2qiuLfyxpO1ajdMpU2Qj6cpEd564AW+HU0ymuh?=
 =?us-ascii?Q?+jVgbn6VBsU1W8zH8Z5nxOhqpMnVe+SERj6kxmaQF+yin1nNvRRJnVh3HiiI?=
 =?us-ascii?Q?cjpgyzaH8anFbpwArs1pOHgaIJrb46PqfMeYlNJbXBQ0YihqtOw7Pn+fQJdp?=
 =?us-ascii?Q?Hgz9jZIot0XavVXSfSUbNoDzhgAyPd4Q24K12ZQL4ykTMdi9VHgrAkAFn92P?=
 =?us-ascii?Q?+oHnhxbYMQPewe2K2WMy7ivBsipIJypEuw/ISthD/L5qpl6icFliEKurfT6k?=
 =?us-ascii?Q?ZWp1gnuVCLZIoZMCZnWheSa1Aml5CuYqdKA9jG/mbMHii/GcOXQGvulZG17Z?=
 =?us-ascii?Q?CYH2w5FwhQGW+R4ytbNhohvU899+78DUm/N9m3Qn93lQONVLOunbEbuBg1Sv?=
 =?us-ascii?Q?NqgAZuC8ZvBZ6pPHQZ9aylcY9KO5IozxJPIrflsEBBBo2q/BQuc88J+YVCUT?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JcF+La57U4bBfLx3tkTX1uZeUjSx7R2zafGtOXxPb4CdHn0whKQ8w5ynt3j2Hb2vY0STkWAxOLX+qRPiacB62M60JJlDa2alIv0f9xvf9zp1sXAoXcoMa5cHgSFPWfiNE/Kl6WR62tohjTkyuFSCeMavHpqkZCHhyChlpfTHhrg8OP2ANXy4AyO0ggVvhErqLI0ydaRhRy82f/iznlYGdqK5VvPlaB8iehV14qNusjdGeKHQzwIZu2SkNNr2CdLCP12MRp8u/1gVtYzLvgcwQlVYKHXUv5yjTgdr4cLbUhxQ3HF8TWQhF3M8MygSeEbGWt7CZHWDVbY05BT4ttLwuLdw4znrPOwnEcd/7lNLhO2FDjZZxRCzoIAjlAPrBBbENQwTEFUUIjDl8yUANKfRuF1q1Eh04TSZTfPqnPWRcVFwFsTSvvXQNsRZHaEdCaB3T2APcgDAuzRlOq2bqOfBmB9QMz4e2yEPBjOPCtsnQVQUo0RVNbtHLUm2UOAaGIewyRZ69RuMROkiW//EZCoefQAA2Eq+X9Obdv4C9DmaQ0bt0DPH//w6USD1kLemQDtGCbDUoXKYbG7iNBlm2akBbDgIINWl7z+X8ZpIWwDJRjE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed91799-3b8b-4605-eb71-08de207fc7b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:37:11.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONLg9Ilt5rUDbgKvuwN4qnnEqaJYFU0dhGZuv2U/0TtWMngWcZLP6UaovT+OJ5FC2MCBOibaYNPLnfdTOY4/QOsO/Xy/7iECf9sxrfM2goc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4474
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0NiBTYWx0ZWRfX7YggrKd5xRyT
 RVXXhfo9rv4w3TaAhAMmZyGW3Qqnp3ab7Q/QNaSygwTA6EBTrxSNKEywhswf+pIzvkxUdYjBxWL
 2+CuD8i1xp7hLU0bT95oSTjTHSNa9p4L5o08CSzF9/ReBFQ87PW0jgGWnkUi9mCfj37XSNT9qzd
 MBtmYkg5zy250RhFrC1rHf0qmT5MBK9ui6gn8YUz7BG2WpC+k+CG17+lmu+6jowIsxHl+XuJatf
 +vFy+P05Ub/aetiHj9TJ7oTM8YFKDMt/X/IGg29/EGg+Sa7+ohdwYNWPnNOA+9/NBr/3XlbIkLm
 09hCDBjXggjbXQb4lp06DWkBNkCdxMpxfaUPNgqV1lyil203eePt441xAP3v9y2dPqC7CaAHMup
 qwUHQBZdA+I7JoncwNhAIoX8dYH9ZjkKe3QHmmhq/RGxN+EWzCw=
X-Authority-Analysis: v=2.4 cv=LIJrgZW9 c=1 sm=1 tr=0 ts=691222cd b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=rULA4o1inuCxW-mqDLMA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12100
X-Proofpoint-ORIG-GUID: ERQ0wydIMBtWe68UqHjkdV_fncMT6stJ
X-Proofpoint-GUID: ERQ0wydIMBtWe68UqHjkdV_fncMT6stJ

On Mon, Nov 10, 2025 at 05:17:13PM +0100, Vlastimil Babka wrote:
> On 11/7/25 17:11, Lorenzo Stoakes wrote:
> > Now we have established the VM_MAYBE_GUARD flag and added the capacity to
> > set it atomically, do so upon MADV_GUARD_INSTALL.
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
> >
> > Note that non-atomic updates of unrelated flags do not cause an issue with
> > this flag being set atomically, as writes of other flags are performed
> > under mmap/VMA write lock, and these atomic writes are performed under
> > mmap/VMA read lock, which excludes the write, avoiding RMW races.
> >
> > Note that we do not encounter issues with KCSAN by adjusting this flag
> > atomically, as we are only updating a single bit in the flag bitmap and
> > therefore we do not need to annotate these changes.
> >
> > We intentionally set this flag in advance of actually updating the page
> > tables, to ensure that any racing atomic read of this flag will only return
> > false prior to page tables being updated, to allow for serialisation via
> > page table locks.
> >
> > Note that we set vma->anon_vma for anonymous mappings. This is because the
> > expectation for anonymous mappings is that an anon_vma is established
> > should they possess any page table mappings. This is also consistent with
> > what we were doing prior to this patch (unconditionally setting anon_vma on
> > guard region installation).
> >
> > We also need to update retract_page_tables() to ensure that madvise(...,
> > MADV_COLLAPSE) doesn't incorrectly collapse file-backed ranges contain
> > guard regions.
> >
> > This was previously guarded by anon_vma being set to catch MAP_PRIVATE
> > cases, but the introduction of VM_MAYBE_GUARD necessitates that we check
> > this flag instead.
> >
> > We utilise vma_flag_test_atomic() to do so - we first perform an optimistic
> > check, then after the PTE page table lock is held, we can check again
> > safely, as upon guard marker install the flag is set atomically prior to
> > the page table lock being taken to actually apply it.
> >
> > So if the initial check fails either:
> >
> > * Page table retraction acquires page table lock prior to VM_MAYBE_GUARD
> >   being set - guard marker installation will be blocked until page table
> >   retraction is complete.
> >
> > OR:
> >
> > * Guard marker installation acquires page table lock after setting
> >   VM_MAYBE_GUARD, which raced and didn't pick this up in the initial
> >   optimistic check, blocking page table retraction until the guard regions
> >   are installed - the second VM_MAYBE_GUARD check will prevent page table
> >   retraction.
> >
> > Either way we're safe.
> >
> > We refactor the retraction checks into a single
> > file_backed_vma_is_retractable(), there doesn't seem to be any reason that
> > the checks were separated as before.
> >
> > Note that VM_MAYBE_GUARD being set atomically remains correct as
> > vma_needs_copy() is invoked with the mmap and VMA write locks held,
> > excluding any race with madvise_guard_install().
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks

>
> Small nit below:
>
> > @@ -1778,15 +1801,16 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
> >  			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> >
> >  		/*
> > -		 * Huge page lock is still held, so normally the page table
> > -		 * must remain empty; and we have already skipped anon_vma
> > -		 * and userfaultfd_wp() vmas.  But since the mmap_lock is not
> > -		 * held, it is still possible for a racing userfaultfd_ioctl()
> > -		 * to have inserted ptes or markers.  Now that we hold ptlock,
> > -		 * repeating the anon_vma check protects from one category,
> > -		 * and repeating the userfaultfd_wp() check from another.
> > +		 * Huge page lock is still held, so normally the page table must
> > +		 * remain empty; and we have already skipped anon_vma and
> > +		 * userfaultfd_wp() vmas.  But since the mmap_lock is not held,
> > +		 * it is still possible for a racing userfaultfd_ioctl() or
> > +		 * madvise() to have inserted ptes or markers.  Now that we hold
> > +		 * ptlock, repeating the anon_vma check protects from one
> > +		 * category, and repeating the userfaultfd_wp() check from
> > +		 * another.
>
> The last part of the comment is unchanged and mentions anon_vma check and
> userfaultfd_wp() check which were there explicitly originally, but now it's
> a file_backed_vma_is_retractable() check that also includes the guard region
> check, so maybe could be updated?

OK will send fix-patch.

>
> >  		 */
> > -		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
> > +		if (likely(file_backed_vma_is_retractable(vma))) {
> >  			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
> >  			pmdp_get_lockless_sync();
> >  			success = true;
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 67bdfcb315b3..de918b107cfc 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1139,15 +1139,21 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
> >  		return -EINVAL;
> >
> >  	/*
> > -	 * If we install guard markers, then the range is no longer
> > -	 * empty from a page table perspective and therefore it's
> > -	 * appropriate to have an anon_vma.
> > -	 *
> > -	 * This ensures that on fork, we copy page tables correctly.
> > +	 * Set atomically under read lock. All pertinent readers will need to
> > +	 * acquire an mmap/VMA write lock to read it. All remaining readers may
> > +	 * or may not see the flag set, but we don't care.
> > +	 */
> > +	vma_flag_set_atomic(vma, VM_MAYBE_GUARD_BIT);
> > +
> > +	/*
> > +	 * If anonymous and we are establishing page tables the VMA ought to
> > +	 * have an anon_vma associated with it.
> >  	 */
> > -	err = anon_vma_prepare(vma);
> > -	if (err)
> > -		return err;
> > +	if (vma_is_anonymous(vma)) {
> > +		err = anon_vma_prepare(vma);
> > +		if (err)
> > +			return err;
> > +	}
> >
> >  	/*
> >  	 * Optimistically try to install the guard marker pages first. If any
>

