Return-Path: <linux-fsdevel+bounces-16339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A856E89B6B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 06:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9981C20F37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 04:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF1B5228;
	Mon,  8 Apr 2024 04:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="G3yGJW20"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241A4A3F
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 04:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549412; cv=fail; b=IssGYN755MscpJ/feeB/do1KYVOvw2D1l9Oa1seMTAHU+I7ZwyQse8HOLu9fIUD8XedcgFEwKtQ5whMm6b7sqnV6uG3+0uhRiwhSmSh8PNyiJFujSCgRovsPwIOlRQv+e6nQZcA5qzCy/UPn+cglWo1RyrF0Mi0VF8p3iUWPSos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549412; c=relaxed/simple;
	bh=R0U1P3qdFsuD1mNrfcio1HPf38qDE4YGSGblpXIo2/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RTjeCRof+uz+WLSJeQqmldCgbzoqftcvOd4Cn5+TyK5Y4gLlpnE5XzGRV81u7Klrf76Gyjd597P4CH4FLarGym4ib62mWg/MIrxZq2R1mSqHhn3bM6XSKu206BHz+F1JJ6jow/ZBavEID8zTDoWKqyduyMP4SxzW3i4nJO5VYyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=G3yGJW20; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4383iU06024381;
	Mon, 8 Apr 2024 04:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=S1;
 bh=U9aHz6qZwKJrL9z93sHZn6Hzuhqkmkzrhk0lTGGIm0g=;
 b=G3yGJW20veQudnWnZZdR0tH+0j9ib5tkRFJ1UMXyLn0E/7SPD6wlLka665MEN16jwL4S
 ReVdgAxFBU4xeKFWLyD6zgnXfbOlEI/EZs0AHDwDtcOL/ssvht0ObktNY+bfFxTiz5w/
 gjsUnDY0GNJF/oSOO1l3jUy+yf7+cJnYChfqS6Jx2yiJfemjALPMBDsAQn4XXIt23szA
 K0A+xfuXgk74UFADwh8JEBpdgxC2xgiuC9AKUWFyMihgV8plR7D171lOXvitARZ7xneU
 GX338VH86Xc5PtxCLM9JQto/P9qE7STRRKb3M602TNhJ4BFnpjhadbeHuBCilDdzVbSP Vg== 
Received: from sg2pr03cu006.outbound.protection.outlook.com (mail-southeastasiaazlp17010000.outbound.protection.outlook.com [40.93.129.0])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3xaxst17u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 04:09:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naH/Rgl6s5k+c8bJFRccRb6vlw6/n1XD3cI7zuGoSsqTzw78Cs2ZYhYS7P7fsDxcXua8pxxay6QcAYnveSi50GuOeMNipZDrzTnX8OmOjI3xtT3R4b4fwFmeVaYAgiFVdKGYyALAKJ9QKAztyXb0v9OaGLnoYgM5Ti4UwxjuOwC220chTJiQC1SndSeRWeXqgkqpC1owRFCgUdCfqj4tQzfe/5rkoCVyQXGTk6oV12na/0Wt8BI0F3KRzGKYbOa/hKi3S5CGXWq8DK2QymL14SeRm8/Z9BWOHg1WTLlSLN4u2AGoXUjAuhwRMl36QHkJnDl2IsBdqiohPGwYG39rXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9aHz6qZwKJrL9z93sHZn6Hzuhqkmkzrhk0lTGGIm0g=;
 b=liAC3i62z04fqeUqbY83Ezf/Bp4iO40M4PjtFnvwaKyGF1fixtaIBvhNGpar3FewYUP/Pn5e3ejCb/QVtg4z6q+l4JiRSRD4QcMQjMA3Z9cs0eOuaWLKF37xjN49LJ0tDcTxsBiwDcWw4qARn8baU1TccCxJBfN5PzIrMLdF+CkS6znFktHCqZy4KS2yZtcNo5UXY3thP+ov11c/DqSASWfuqB6rCFgjFyIdxuoyHqfmEHbTkO4IUtElMXphykYVjMVF4jc8Ub3n5AvjRgMT1kDz6y/58mgh0BFeXbJM9gZDKttbh963W9PMKaSZonXE7aHBpqaxNzaH1/7GHKnWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SG2PR04MB5769.apcprd04.prod.outlook.com (2603:1096:4:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 04:09:20 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::b59d:42cd:35d:351e]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::b59d:42cd:35d:351e%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 04:09:20 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        Matthew Wilcox <willy@infradead.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
Subject: [PATCH v2] exfat: move extend valid_size into ->page_mkwrite()
Thread-Topic: [PATCH v2] exfat: move extend valid_size into ->page_mkwrite()
Thread-Index: AQHaiWnQ7a+r99yPRUWKkEXVY33clw==
Date: Mon, 8 Apr 2024 04:09:20 +0000
Message-ID: 
 <PUZPR04MB63160EDE1B2FB47D80B717D481002@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SG2PR04MB5769:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EF+lgK9KZ2B1AkiwNtyS7ZNYcpgWqIwLSlUWJMWHYrELdvov0hbfqVdOMZJYgiPyJh2z5uRi+n+0U00LW1908MY/ADr17xYHPPyiCJme7zRZ7GMB9DzEf8o3s8QGPsDUs+TK8c4/1hMkFA6MyUPgYTFDshtKqOnXzwYqu5GUdUkWYkbLK1dxSiwNiXF4yB8vRF76hQEWm33gmABDjSXF8g/n6sFrsnFdTj7w0IUSG6Sm9lhVeBZXG0pmn40pTsS28/aF/S+z30Anl7j3Ueb7Q2cVwjIxqUsnjWkAk7gjMMoKX5D9KKZ19mpjyC1FJdjZlQm/cgx8+6TbJNpL4wNkcK/sStrTrikEnz9wSne8rGNWa/IEgWcf0WdhA67scXIFmXbIWO90kd5l//eFG7PQFmGGl12GRnMZpa/qu8hpiIkPqGlGjb6oDxeH4zrjLAAtf1CbgdQy83fJUjIA7SlPyCyVugt8GBVW5F+g0rv1ncPdCe+RarbbPCz6HhbxKykUYVWFqeZPL6mAvTpn0No9JyRngFcNs+WIDSbzLBJYceH6cy/wUJvIey40MkN0po7eDJwFe/h6hFCPmSTIIwGM1PrgrG6lzimgGxWimzARL3TYYav5Bq25LiFP2fBHZx6r0/rbnwhqQd0+2MYlGhe8YGiH8l/3L/psRkGkSkaBXgs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?bZc0EXGHCm5qMsOkql8m1XPc1Sy3Zf3xYR5TOKgnMdt0TVeACGncJZYBHN?=
 =?iso-8859-1?Q?dNgqEDWV/bF7dmGHD6wd0NqSnVYA9VBIdgmCsqyYHX/RWJuDxjHb9xOANe?=
 =?iso-8859-1?Q?+WHy4mCyHYRNtun1IZjTt1BUeNCAkjCBAEpEnYbjF6+4PaQlpWLd2pREwk?=
 =?iso-8859-1?Q?GIyuprgxO6tYiA+BabAxa80T5UhumcLzOCtKjzdKVIxQ/V+YXtuCb7H9zC?=
 =?iso-8859-1?Q?PtjvRbftVkufKgLq3BSKF+WfU8zLtVV3vG4OTCDlBb6c8Sxaj7rS0FGvcN?=
 =?iso-8859-1?Q?CMzoMos6e9LO2h9YviFqEwKnzK+NreRG7yO/TBYikx8hMyEVLCwp74s0Kp?=
 =?iso-8859-1?Q?07uuovGJj8yoKDWCE+trsyRXz3eAbj6uV8CBFZlt8TAu0foVR25qvmSk4K?=
 =?iso-8859-1?Q?A+du7n7KSfRDAKcyC2fhyHu1hKJGHz3zsCcxwn1HK7yEiB+5/EBkgg+/Ki?=
 =?iso-8859-1?Q?5lXZyUczJfn0POJADoCE+G2K6GHczagGeg0h3cr2KGN2kJhyqpC6b25w4K?=
 =?iso-8859-1?Q?4O9jkej6PRevve6m5p+LpVdevMtmQl6S0fqV726HzKx1UKzroVD4XUsAF+?=
 =?iso-8859-1?Q?eQw1pcZd8c4dxX+GuCeN7aeqoLC+N9yxbtQr4LkGfLu32c/5XiR7VHzrM3?=
 =?iso-8859-1?Q?rTmhgXTpndVXxk+TumNuTMEd/GARrx2HqGNdF9PADMDFzd6UzxXoYlEKfI?=
 =?iso-8859-1?Q?kBS3SN4LxYdV4q76nXybjEg/k7ukL+AXuL1nKFnjJfGYa/K99EQ4DJezaz?=
 =?iso-8859-1?Q?y9KB8fs+qiZHRIGRsVWvGT0sOSJN8o+t+RpBbw+IDWfHpm5IY9FouFhpvg?=
 =?iso-8859-1?Q?Xf6jRvJVR+moVhiPaa+6vHQOQv9MgdrR2ytP35umf+Xt3s3uoranfeW0fR?=
 =?iso-8859-1?Q?h4hv+m1z9pSjT1HZSQ4CMAU9iGcCmc1E9uC8rkBcAtfFmPjGdYtMruZcQe?=
 =?iso-8859-1?Q?bSUosNrdgYdDfSUrIImCa5uBwV7fmfD1cdtlA/Q19TKoHoV1PXo9ShIgIJ?=
 =?iso-8859-1?Q?+i+ac1AFpSNRY2u8sleG9xYTITFlZDPNCP+a9m4wAL5N39UF7d4ekbZWhI?=
 =?iso-8859-1?Q?ajT5tUondhuTngktWnXKlppQOjgb07glgjvvB6RCOu6qtatXhbQIGFTlto?=
 =?iso-8859-1?Q?q0gL1XKTCOm50zcRDbwUEMCYhm6SXRkJYehGbTdtxCp07neja9mAdyn9lp?=
 =?iso-8859-1?Q?AsDLlhOUC8CBo4uL6vm0bTP2PqPV203V0fAVvA52iOliF7u4/QgZQx8IkP?=
 =?iso-8859-1?Q?RX6kZSZhDFrzJ4eDD0eQSHFzijFLbTwdkG7n6K/rcWKWC3crG+c4XYtQSz?=
 =?iso-8859-1?Q?gHLElNj5T8JXwbiKgli0DU1/I4nyMg0+uYtSbpogKywuhQaCtoq9f2Jlz9?=
 =?iso-8859-1?Q?iuzrHlCuTl9uvXDlMcezeKemJoSbjkmsNAdvz9Oo5h2BBzLkjBtLA+hMQ7?=
 =?iso-8859-1?Q?CWyQMKQk8VPVIbyKRU6P8u80Uj1pAJ/M98FBflz60Rw14r5W68AUQBTe88?=
 =?iso-8859-1?Q?45WxaNVwS9JjavsOzhJanPAlGiJdXvpbdJyt3Ckd6an057XlmVPkKnz/vm?=
 =?iso-8859-1?Q?eloicgFSuGxhHnJhXABYFH+QjP/HQwvCNk9zm8dsVZUjUp9Q9vFoOwGgqH?=
 =?iso-8859-1?Q?qCeFLWAJ17B3ah3RBelefTfplWxGZnjk9UhDvBLVHRRa+WxTkLVmkAqq9E?=
 =?iso-8859-1?Q?kVRgclFJjmpLu348N8U=3D?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7+fz8RyxZHmTfTSyUYSGQrbLW6BKnhMRnm1LgZa+NGWqTC0a1PjOageNtf6BqDnKJ3ZeVYyhcjn0gF7RH8u6NZnCd1vGmr51Acn5Z6l7MtmmDqwa6uLT6IsPrUAsbMmbCfhwEGY6LbL10JSq/tUulcJHdJB4M6m0HX4OmWwv8K3fmvOKEd/Zb8sRQa+KUfVIJ36Dvgr3V8NmaJFcEBiFRgGCeS7/uIKxg1OlJBR1ICcQIN86AD9Jou8W3O68rUKdsHAOU7XNtqYbErKylDpiGgDYgllFdM81WIxy/J77tVCvSa0omFmDWbJqU+BRgle0796wFKP6Puvle6jwvP5/svzfiddqjvXOEfl1lB+WoBHZR1ezKOvKRaSZUuV/CEDm3oehUOCMybEGWbw1q3Jn4LGjpaP/dnDDL77i8tV9FpZslj57RMkM7z/xYB95UK1CPofpllwEdTZY1RzfoS0FzyNC5ZVRALk+iY1+OYCwQKauLr3AHsZAZWWkTonMPCq4XnNBEggnkNSbp9L8mXHkNBQENRESoN+WlDFrq1ao6MRRmkYYDsW4zE4WOfmyjSVtXsSOALUliqIaVP5RYs5Z7GlTjiz+djmRvLeC73CrkAk6ATxOOv7YtZaoTYyO9epe
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af557c7-922d-4b81-725e-08dc5781aa62
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 04:09:20.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmoEVfmXBKpK0Kd0IZsXiPQPHzO3Qspz9U+8DzHKNMdSvqkNwuH/4xZvLFz4YWs3rR64NP+hiyz8ZYk0fDhjMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5769
X-Proofpoint-ORIG-GUID: XyxtheQlFkrRKEu7Kn5vvVt8q9XFLvp5
X-Proofpoint-GUID: XyxtheQlFkrRKEu7Kn5vvVt8q9XFLvp5
Content-Type: multipart/mixed;	boundary="_002_PUZPR04MB63160EDE1B2FB47D80B717D481002PUZPR04MB6316apcp_"
X-Sony-Outbound-GUID: XyxtheQlFkrRKEu7Kn5vvVt8q9XFLvp5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_01,2024-04-05_02,2023-05-22_02

--_002_PUZPR04MB63160EDE1B2FB47D80B717D481002PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

It is not a good way to extend valid_size to the end of the=0A=
mmap area by writing zeros in mmap. Because after calling mmap,=0A=
no data may be written, or only a small amount of data may be=0A=
written to the head of the mmap area.=0A=
=0A=
This commit moves extending valid_size to exfat_page_mkwrite().=0A=
In exfat_page_mkwrite() only extend valid_size to the starting=0A=
position of new data writing, which reduces unnecessary writing=0A=
of zeros.=0A=
=0A=
If the block is not mapped and is marked as new after being=0A=
mapped for writing, block_write_begin() will zero the page=0A=
cache corresponding to the block, so there is no need to call=0A=
zero_user_segment() in exfat_file_zeroed_range(). And after moving=0A=
extending valid_size to exfat_page_mkwrite(), the data written by=0A=
mmap will be copied to the page cache but the page cache may be=0A=
not mapped to the disk. Calling zero_user_segment() will cause=0A=
the data written by mmap to be cleared. So this commit removes=0A=
calling zero_user_segment() from exfat_file_zeroed_range() and=0A=
renames exfat_file_zeroed_range() to exfat_extend_valid_size().=0A=
=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
=0A=
Changes for v2:=0A=
  - Remove a unnecessary check from exfat_file_mmap()=0A=
=0A=
---=0A=
 fs/exfat/exfat_fs.h |  1 +=0A=
 fs/exfat/file.c     | 97 +++++++++++++++++++++++++++++++++++----------=0A=
 fs/exfat/inode.c    |  5 +++=0A=
 3 files changed, 83 insertions(+), 20 deletions(-)=0A=
=0A=
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h=0A=
index ecc5db952deb..1d207eee3197 100644=0A=
--- a/fs/exfat/exfat_fs.h=0A=
+++ b/fs/exfat/exfat_fs.h=0A=
@@ -516,6 +516,7 @@ int __exfat_write_inode(struct inode *inode, int sync);=
=0A=
 int exfat_write_inode(struct inode *inode, struct writeback_control *wbc);=
=0A=
 void exfat_evict_inode(struct inode *inode);=0A=
 int exfat_block_truncate_page(struct inode *inode, loff_t from);=0A=
+int exfat_block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *=
vmf);=0A=
 =0A=
 /* exfat/nls.c */=0A=
 unsigned short exfat_toupper(struct super_block *sb, unsigned short a);=0A=
diff --git a/fs/exfat/file.c b/fs/exfat/file.c=0A=
index cc00f1a7a1e1..95d3e7f8b911 100644=0A=
--- a/fs/exfat/file.c=0A=
+++ b/fs/exfat/file.c=0A=
@@ -523,7 +523,7 @@ int exfat_file_fsync(struct file *filp, loff_t start, l=
off_t end, int datasync)=0A=
 	return blkdev_issue_flush(inode->i_sb->s_bdev);=0A=
 }=0A=
 =0A=
-static int exfat_file_zeroed_range(struct file *file, loff_t start, loff_t=
 end)=0A=
+static int exfat_extend_valid_size(struct file *file, loff_t start, loff_t=
 end)=0A=
 {=0A=
 	int err;=0A=
 	struct inode *inode =3D file_inode(file);=0A=
@@ -531,11 +531,10 @@ static int exfat_file_zeroed_range(struct file *file,=
 loff_t start, loff_t end)=0A=
 	const struct address_space_operations *ops =3D mapping->a_ops;=0A=
 =0A=
 	while (start < end) {=0A=
-		u32 zerofrom, len;=0A=
+		u32 len;=0A=
 		struct page *page =3D NULL;=0A=
 =0A=
-		zerofrom =3D start & (PAGE_SIZE - 1);=0A=
-		len =3D PAGE_SIZE - zerofrom;=0A=
+		len =3D PAGE_SIZE - (start & (PAGE_SIZE - 1));=0A=
 		if (start + len > end)=0A=
 			len =3D end - start;=0A=
 =0A=
@@ -543,8 +542,6 @@ static int exfat_file_zeroed_range(struct file *file, l=
off_t start, loff_t end)=0A=
 		if (err)=0A=
 			goto out;=0A=
 =0A=
-		zero_user_segment(page, zerofrom, zerofrom + len);=0A=
-=0A=
 		err =3D ops->write_end(file, mapping, start, len, len, page, NULL);=0A=
 		if (err < 0)=0A=
 			goto out;=0A=
@@ -576,7 +573,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb=
, struct iov_iter *iter)=0A=
 		goto unlock;=0A=
 =0A=
 	if (pos > valid_size) {=0A=
-		ret =3D exfat_file_zeroed_range(file, valid_size, pos);=0A=
+		ret =3D exfat_extend_valid_size(file, valid_size, pos);=0A=
 		if (ret < 0 && ret !=3D -ENOSPC) {=0A=
 			exfat_err(inode->i_sb,=0A=
 				"write: fail to zero from %llu to %llu(%zd)",=0A=
@@ -610,26 +607,86 @@ static ssize_t exfat_file_write_iter(struct kiocb *io=
cb, struct iov_iter *iter)=0A=
 	return ret;=0A=
 }=0A=
 =0A=
-static int exfat_file_mmap(struct file *file, struct vm_area_struct *vma)=
=0A=
+static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)=0A=
 {=0A=
-	int ret;=0A=
+	int err;=0A=
+	struct vm_area_struct *vma =3D vmf->vma;=0A=
+	struct file *file =3D vma->vm_file;=0A=
 	struct inode *inode =3D file_inode(file);=0A=
 	struct exfat_inode_info *ei =3D EXFAT_I(inode);=0A=
-	loff_t start =3D ((loff_t)vma->vm_pgoff << PAGE_SHIFT);=0A=
-	loff_t end =3D min_t(loff_t, i_size_read(inode),=0A=
-			start + vma->vm_end - vma->vm_start);=0A=
+	struct folio *folio =3D page_folio(vmf->page);=0A=
+	vm_fault_t ret =3D VM_FAULT_LOCKED;=0A=
+=0A=
+	sb_start_pagefault(inode->i_sb);=0A=
+	file_update_time(file);=0A=
+	folio_lock(folio);=0A=
+	if (folio->mapping !=3D file->f_mapping) {=0A=
+		folio_unlock(folio);=0A=
+		ret =3D VM_FAULT_NOPAGE;=0A=
+		goto out;=0A=
+	}=0A=
 =0A=
-	if ((vma->vm_flags & VM_WRITE) && ei->valid_size < end) {=0A=
-		ret =3D exfat_file_zeroed_range(file, ei->valid_size, end);=0A=
-		if (ret < 0) {=0A=
-			exfat_err(inode->i_sb,=0A=
-				  "mmap: fail to zero from %llu to %llu(%d)",=0A=
-				  start, end, ret);=0A=
-			return ret;=0A=
+	if (ei->valid_size < folio_pos(folio)) {=0A=
+		inode_lock(inode);=0A=
+		err =3D exfat_extend_valid_size(file, ei->valid_size, folio_pos(folio));=
=0A=
+		inode_unlock(inode);=0A=
+		if (err < 0) {=0A=
+			ret =3D vmf_fs_error(err);=0A=
+			goto out;=0A=
 		}=0A=
 	}=0A=
 =0A=
-	return generic_file_mmap(file, vma);=0A=
+	/*=0A=
+	 * check if the folio is mapped already (Whether ei->valid_size=0A=
+	 * has been extended to folio_pos(folio)+folio_len(folio))=0A=
+	 */=0A=
+	if (!folio_test_mappedtodisk(folio)) {=0A=
+		struct buffer_head *head =3D folio_buffers(folio);=0A=
+=0A=
+		if (head) {=0A=
+			int fully_mapped =3D 1;=0A=
+			struct buffer_head *bh =3D head;=0A=
+=0A=
+			do {=0A=
+				if (!buffer_mapped(bh)) {=0A=
+					fully_mapped =3D 0;=0A=
+					break;=0A=
+				}=0A=
+			} while (bh =3D bh->b_this_page, bh !=3D head);=0A=
+=0A=
+			if (fully_mapped)=0A=
+				folio_set_mappedtodisk(folio);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	if (folio_test_mappedtodisk(folio)) {=0A=
+		folio_mark_dirty(folio);=0A=
+		folio_wait_stable(folio);=0A=
+		goto out;=0A=
+	}=0A=
+=0A=
+	folio_unlock(folio);=0A=
+=0A=
+	err =3D exfat_block_page_mkwrite(vma, vmf);=0A=
+	if (err)=0A=
+		ret =3D vmf_fs_error(err);=0A=
+=0A=
+out:=0A=
+	sb_end_pagefault(inode->i_sb);=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static const struct vm_operations_struct exfat_file_vm_ops =3D {=0A=
+	.fault		=3D filemap_fault,=0A=
+	.map_pages	=3D filemap_map_pages,=0A=
+	.page_mkwrite	=3D exfat_page_mkwrite,=0A=
+};=0A=
+=0A=
+static int exfat_file_mmap(struct file *file, struct vm_area_struct *vma)=
=0A=
+{=0A=
+	file_accessed(file);=0A=
+	vma->vm_ops =3D &exfat_file_vm_ops;=0A=
+	return 0;=0A=
 }=0A=
 =0A=
 const struct file_operations exfat_file_operations =3D {=0A=
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c=0A=
index dd894e558c91..804de7496a7f 100644=0A=
--- a/fs/exfat/inode.c=0A=
+++ b/fs/exfat/inode.c=0A=
@@ -564,6 +564,11 @@ int exfat_block_truncate_page(struct inode *inode, lof=
f_t from)=0A=
 	return block_truncate_page(inode->i_mapping, from, exfat_get_block);=0A=
 }=0A=
 =0A=
+int exfat_block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *=
vmf)=0A=
+{=0A=
+	return block_page_mkwrite(vma, vmf, exfat_get_block);=0A=
+}=0A=
+=0A=
 static const struct address_space_operations exfat_aops =3D {=0A=
 	.dirty_folio	=3D block_dirty_folio,=0A=
 	.invalidate_folio =3D block_invalidate_folio,=0A=
-- =0A=
2.34.1=

--_002_PUZPR04MB63160EDE1B2FB47D80B717D481002PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v2-0001-exfat-move-extend-valid_size-into-page_mkwrite.patch"
Content-Description: 
 v2-0001-exfat-move-extend-valid_size-into-page_mkwrite.patch
Content-Disposition: attachment;
	filename="v2-0001-exfat-move-extend-valid_size-into-page_mkwrite.patch";
	size=6938; creation-date="Mon, 08 Apr 2024 04:06:22 GMT";
	modification-date="Mon, 08 Apr 2024 04:06:22 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5Yzg2NzA0YWI5YmFiZTM3M2JiZTQzMWY4ZWZmNmM4Y2I1NjViNmJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IEZyaSwgOCBNYXIgMjAyNCAxNDowMzo0NiArMDgwMApTdWJqZWN0OiBbUEFUQ0ggdjJdIGV4
ZmF0OiBtb3ZlIGV4dGVuZCB2YWxpZF9zaXplIGludG8gLT5wYWdlX21rd3JpdGUoKQoKSXQgaXMg
bm90IGEgZ29vZCB3YXkgdG8gZXh0ZW5kIHZhbGlkX3NpemUgdG8gdGhlIGVuZCBvZiB0aGUKbW1h
cCBhcmVhIGJ5IHdyaXRpbmcgemVyb3MgaW4gbW1hcC4gQmVjYXVzZSBhZnRlciBjYWxsaW5nIG1t
YXAsCm5vIGRhdGEgbWF5IGJlIHdyaXR0ZW4sIG9yIG9ubHkgYSBzbWFsbCBhbW91bnQgb2YgZGF0
YSBtYXkgYmUKd3JpdHRlbiB0byB0aGUgaGVhZCBvZiB0aGUgbW1hcCBhcmVhLgoKVGhpcyBjb21t
aXQgbW92ZXMgZXh0ZW5kaW5nIHZhbGlkX3NpemUgdG8gZXhmYXRfcGFnZV9ta3dyaXRlKCkuCklu
IGV4ZmF0X3BhZ2VfbWt3cml0ZSgpIG9ubHkgZXh0ZW5kIHZhbGlkX3NpemUgdG8gdGhlIHN0YXJ0
aW5nCnBvc2l0aW9uIG9mIG5ldyBkYXRhIHdyaXRpbmcsIHdoaWNoIHJlZHVjZXMgdW5uZWNlc3Nh
cnkgd3JpdGluZwpvZiB6ZXJvcy4KCklmIHRoZSBibG9jayBpcyBub3QgbWFwcGVkIGFuZCBpcyBt
YXJrZWQgYXMgbmV3IGFmdGVyIGJlaW5nCm1hcHBlZCBmb3Igd3JpdGluZywgYmxvY2tfd3JpdGVf
YmVnaW4oKSB3aWxsIHplcm8gdGhlIHBhZ2UKY2FjaGUgY29ycmVzcG9uZGluZyB0byB0aGUgYmxv
Y2ssIHNvIHRoZXJlIGlzIG5vIG5lZWQgdG8gY2FsbAp6ZXJvX3VzZXJfc2VnbWVudCgpIGluIGV4
ZmF0X2ZpbGVfemVyb2VkX3JhbmdlKCkuIEFuZCBhZnRlciBtb3ZpbmcKZXh0ZW5kaW5nIHZhbGlk
X3NpemUgdG8gZXhmYXRfcGFnZV9ta3dyaXRlKCksIHRoZSBkYXRhIHdyaXR0ZW4gYnkKbW1hcCB3
aWxsIGJlIGNvcGllZCB0byB0aGUgcGFnZSBjYWNoZSBidXQgdGhlIHBhZ2UgY2FjaGUgbWF5IGJl
Cm5vdCBtYXBwZWQgdG8gdGhlIGRpc2suIENhbGxpbmcgemVyb191c2VyX3NlZ21lbnQoKSB3aWxs
IGNhdXNlCnRoZSBkYXRhIHdyaXR0ZW4gYnkgbW1hcCB0byBiZSBjbGVhcmVkLiBTbyB0aGlzIGNv
bW1pdCByZW1vdmVzCmNhbGxpbmcgemVyb191c2VyX3NlZ21lbnQoKSBmcm9tIGV4ZmF0X2ZpbGVf
emVyb2VkX3JhbmdlKCkgYW5kCnJlbmFtZXMgZXhmYXRfZmlsZV96ZXJvZWRfcmFuZ2UoKSB0byBl
eGZhdF9leHRlbmRfdmFsaWRfc2l6ZSgpLgoKU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1
ZXpoYW5nLk1vQHNvbnkuY29tPgoKQ2hhbmdlcyBmb3IgdjI6CiAgLSBSZW1vdmUgYSB1bm5lY2Vz
c2FyeSBjaGVjayBmcm9tIGV4ZmF0X2ZpbGVfbW1hcCgpCgotLS0KIGZzL2V4ZmF0L2V4ZmF0X2Zz
LmggfCAgMSArCiBmcy9leGZhdC9maWxlLmMgICAgIHwgOTcgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tCiBmcy9leGZhdC9pbm9kZS5jICAgIHwgIDUgKysrCiAz
IGZpbGVzIGNoYW5nZWQsIDgzIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmggYi9mcy9leGZhdC9leGZhdF9mcy5oCmluZGV4IGVj
YzVkYjk1MmRlYi4uMWQyMDdlZWUzMTk3IDEwMDY0NAotLS0gYS9mcy9leGZhdC9leGZhdF9mcy5o
CisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgKQEAgLTUxNiw2ICs1MTYsNyBAQCBpbnQgX19leGZh
dF93cml0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBpbnQgc3luYyk7CiBpbnQgZXhmYXRf
d3JpdGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IHdyaXRlYmFja19jb250cm9s
ICp3YmMpOwogdm9pZCBleGZhdF9ldmljdF9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlKTsKIGlu
dCBleGZhdF9ibG9ja190cnVuY2F0ZV9wYWdlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZfdCBm
cm9tKTsKK2ludCBleGZhdF9ibG9ja19wYWdlX21rd3JpdGUoc3RydWN0IHZtX2FyZWFfc3RydWN0
ICp2bWEsIHN0cnVjdCB2bV9mYXVsdCAqdm1mKTsKIAogLyogZXhmYXQvbmxzLmMgKi8KIHVuc2ln
bmVkIHNob3J0IGV4ZmF0X3RvdXBwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQg
c2hvcnQgYSk7CmRpZmYgLS1naXQgYS9mcy9leGZhdC9maWxlLmMgYi9mcy9leGZhdC9maWxlLmMK
aW5kZXggY2MwMGYxYTdhMWUxLi45NWQzZTdmOGI5MTEgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L2Zp
bGUuYworKysgYi9mcy9leGZhdC9maWxlLmMKQEAgLTUyMyw3ICs1MjMsNyBAQCBpbnQgZXhmYXRf
ZmlsZV9mc3luYyhzdHJ1Y3QgZmlsZSAqZmlscCwgbG9mZl90IHN0YXJ0LCBsb2ZmX3QgZW5kLCBp
bnQgZGF0YXN5bmMpCiAJcmV0dXJuIGJsa2Rldl9pc3N1ZV9mbHVzaChpbm9kZS0+aV9zYi0+c19i
ZGV2KTsKIH0KIAotc3RhdGljIGludCBleGZhdF9maWxlX3plcm9lZF9yYW5nZShzdHJ1Y3QgZmls
ZSAqZmlsZSwgbG9mZl90IHN0YXJ0LCBsb2ZmX3QgZW5kKQorc3RhdGljIGludCBleGZhdF9leHRl
bmRfdmFsaWRfc2l6ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgbG9mZl90IHN0YXJ0LCBsb2ZmX3QgZW5k
KQogewogCWludCBlcnI7CiAJc3RydWN0IGlub2RlICppbm9kZSA9IGZpbGVfaW5vZGUoZmlsZSk7
CkBAIC01MzEsMTEgKzUzMSwxMCBAQCBzdGF0aWMgaW50IGV4ZmF0X2ZpbGVfemVyb2VkX3Jhbmdl
KHN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3Qgc3RhcnQsIGxvZmZfdCBlbmQpCiAJY29uc3Qgc3Ry
dWN0IGFkZHJlc3Nfc3BhY2Vfb3BlcmF0aW9ucyAqb3BzID0gbWFwcGluZy0+YV9vcHM7CiAKIAl3
aGlsZSAoc3RhcnQgPCBlbmQpIHsKLQkJdTMyIHplcm9mcm9tLCBsZW47CisJCXUzMiBsZW47CiAJ
CXN0cnVjdCBwYWdlICpwYWdlID0gTlVMTDsKIAotCQl6ZXJvZnJvbSA9IHN0YXJ0ICYgKFBBR0Vf
U0laRSAtIDEpOwotCQlsZW4gPSBQQUdFX1NJWkUgLSB6ZXJvZnJvbTsKKwkJbGVuID0gUEFHRV9T
SVpFIC0gKHN0YXJ0ICYgKFBBR0VfU0laRSAtIDEpKTsKIAkJaWYgKHN0YXJ0ICsgbGVuID4gZW5k
KQogCQkJbGVuID0gZW5kIC0gc3RhcnQ7CiAKQEAgLTU0Myw4ICs1NDIsNiBAQCBzdGF0aWMgaW50
IGV4ZmF0X2ZpbGVfemVyb2VkX3JhbmdlKHN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3Qgc3RhcnQs
IGxvZmZfdCBlbmQpCiAJCWlmIChlcnIpCiAJCQlnb3RvIG91dDsKIAotCQl6ZXJvX3VzZXJfc2Vn
bWVudChwYWdlLCB6ZXJvZnJvbSwgemVyb2Zyb20gKyBsZW4pOwotCiAJCWVyciA9IG9wcy0+d3Jp
dGVfZW5kKGZpbGUsIG1hcHBpbmcsIHN0YXJ0LCBsZW4sIGxlbiwgcGFnZSwgTlVMTCk7CiAJCWlm
IChlcnIgPCAwKQogCQkJZ290byBvdXQ7CkBAIC01NzYsNyArNTczLDcgQEAgc3RhdGljIHNzaXpl
X3QgZXhmYXRfZmlsZV93cml0ZV9pdGVyKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9p
dGVyICppdGVyKQogCQlnb3RvIHVubG9jazsKIAogCWlmIChwb3MgPiB2YWxpZF9zaXplKSB7Ci0J
CXJldCA9IGV4ZmF0X2ZpbGVfemVyb2VkX3JhbmdlKGZpbGUsIHZhbGlkX3NpemUsIHBvcyk7CisJ
CXJldCA9IGV4ZmF0X2V4dGVuZF92YWxpZF9zaXplKGZpbGUsIHZhbGlkX3NpemUsIHBvcyk7CiAJ
CWlmIChyZXQgPCAwICYmIHJldCAhPSAtRU5PU1BDKSB7CiAJCQlleGZhdF9lcnIoaW5vZGUtPmlf
c2IsCiAJCQkJIndyaXRlOiBmYWlsIHRvIHplcm8gZnJvbSAlbGx1IHRvICVsbHUoJXpkKSIsCkBA
IC02MTAsMjYgKzYwNyw4NiBAQCBzdGF0aWMgc3NpemVfdCBleGZhdF9maWxlX3dyaXRlX2l0ZXIo
c3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpCiAJcmV0dXJuIHJldDsK
IH0KIAotc3RhdGljIGludCBleGZhdF9maWxlX21tYXAoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVj
dCB2bV9hcmVhX3N0cnVjdCAqdm1hKQorc3RhdGljIHZtX2ZhdWx0X3QgZXhmYXRfcGFnZV9ta3dy
aXRlKHN0cnVjdCB2bV9mYXVsdCAqdm1mKQogewotCWludCByZXQ7CisJaW50IGVycjsKKwlzdHJ1
Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSA9IHZtZi0+dm1hOworCXN0cnVjdCBmaWxlICpmaWxlID0g
dm1hLT52bV9maWxlOwogCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBmaWxlX2lub2RlKGZpbGUpOwog
CXN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSA9IEVYRkFUX0koaW5vZGUpOwotCWxvZmZfdCBz
dGFydCA9ICgobG9mZl90KXZtYS0+dm1fcGdvZmYgPDwgUEFHRV9TSElGVCk7Ci0JbG9mZl90IGVu
ZCA9IG1pbl90KGxvZmZfdCwgaV9zaXplX3JlYWQoaW5vZGUpLAotCQkJc3RhcnQgKyB2bWEtPnZt
X2VuZCAtIHZtYS0+dm1fc3RhcnQpOworCXN0cnVjdCBmb2xpbyAqZm9saW8gPSBwYWdlX2ZvbGlv
KHZtZi0+cGFnZSk7CisJdm1fZmF1bHRfdCByZXQgPSBWTV9GQVVMVF9MT0NLRUQ7CisKKwlzYl9z
dGFydF9wYWdlZmF1bHQoaW5vZGUtPmlfc2IpOworCWZpbGVfdXBkYXRlX3RpbWUoZmlsZSk7CisJ
Zm9saW9fbG9jayhmb2xpbyk7CisJaWYgKGZvbGlvLT5tYXBwaW5nICE9IGZpbGUtPmZfbWFwcGlu
ZykgeworCQlmb2xpb191bmxvY2soZm9saW8pOworCQlyZXQgPSBWTV9GQVVMVF9OT1BBR0U7CisJ
CWdvdG8gb3V0OworCX0KIAotCWlmICgodm1hLT52bV9mbGFncyAmIFZNX1dSSVRFKSAmJiBlaS0+
dmFsaWRfc2l6ZSA8IGVuZCkgewotCQlyZXQgPSBleGZhdF9maWxlX3plcm9lZF9yYW5nZShmaWxl
LCBlaS0+dmFsaWRfc2l6ZSwgZW5kKTsKLQkJaWYgKHJldCA8IDApIHsKLQkJCWV4ZmF0X2Vycihp
bm9kZS0+aV9zYiwKLQkJCQkgICJtbWFwOiBmYWlsIHRvIHplcm8gZnJvbSAlbGx1IHRvICVsbHUo
JWQpIiwKLQkJCQkgIHN0YXJ0LCBlbmQsIHJldCk7Ci0JCQlyZXR1cm4gcmV0OworCWlmIChlaS0+
dmFsaWRfc2l6ZSA8IGZvbGlvX3Bvcyhmb2xpbykpIHsKKwkJaW5vZGVfbG9jayhpbm9kZSk7CisJ
CWVyciA9IGV4ZmF0X2V4dGVuZF92YWxpZF9zaXplKGZpbGUsIGVpLT52YWxpZF9zaXplLCBmb2xp
b19wb3MoZm9saW8pKTsKKwkJaW5vZGVfdW5sb2NrKGlub2RlKTsKKwkJaWYgKGVyciA8IDApIHsK
KwkJCXJldCA9IHZtZl9mc19lcnJvcihlcnIpOworCQkJZ290byBvdXQ7CiAJCX0KIAl9CiAKLQly
ZXR1cm4gZ2VuZXJpY19maWxlX21tYXAoZmlsZSwgdm1hKTsKKwkvKgorCSAqIGNoZWNrIGlmIHRo
ZSBmb2xpbyBpcyBtYXBwZWQgYWxyZWFkeSAoV2hldGhlciBlaS0+dmFsaWRfc2l6ZQorCSAqIGhh
cyBiZWVuIGV4dGVuZGVkIHRvIGZvbGlvX3Bvcyhmb2xpbykrZm9saW9fbGVuKGZvbGlvKSkKKwkg
Ki8KKwlpZiAoIWZvbGlvX3Rlc3RfbWFwcGVkdG9kaXNrKGZvbGlvKSkgeworCQlzdHJ1Y3QgYnVm
ZmVyX2hlYWQgKmhlYWQgPSBmb2xpb19idWZmZXJzKGZvbGlvKTsKKworCQlpZiAoaGVhZCkgewor
CQkJaW50IGZ1bGx5X21hcHBlZCA9IDE7CisJCQlzdHJ1Y3QgYnVmZmVyX2hlYWQgKmJoID0gaGVh
ZDsKKworCQkJZG8geworCQkJCWlmICghYnVmZmVyX21hcHBlZChiaCkpIHsKKwkJCQkJZnVsbHlf
bWFwcGVkID0gMDsKKwkJCQkJYnJlYWs7CisJCQkJfQorCQkJfSB3aGlsZSAoYmggPSBiaC0+Yl90
aGlzX3BhZ2UsIGJoICE9IGhlYWQpOworCisJCQlpZiAoZnVsbHlfbWFwcGVkKQorCQkJCWZvbGlv
X3NldF9tYXBwZWR0b2Rpc2soZm9saW8pOworCQl9CisJfQorCisJaWYgKGZvbGlvX3Rlc3RfbWFw
cGVkdG9kaXNrKGZvbGlvKSkgeworCQlmb2xpb19tYXJrX2RpcnR5KGZvbGlvKTsKKwkJZm9saW9f
d2FpdF9zdGFibGUoZm9saW8pOworCQlnb3RvIG91dDsKKwl9CisKKwlmb2xpb191bmxvY2soZm9s
aW8pOworCisJZXJyID0gZXhmYXRfYmxvY2tfcGFnZV9ta3dyaXRlKHZtYSwgdm1mKTsKKwlpZiAo
ZXJyKQorCQlyZXQgPSB2bWZfZnNfZXJyb3IoZXJyKTsKKworb3V0OgorCXNiX2VuZF9wYWdlZmF1
bHQoaW5vZGUtPmlfc2IpOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
dm1fb3BlcmF0aW9uc19zdHJ1Y3QgZXhmYXRfZmlsZV92bV9vcHMgPSB7CisJLmZhdWx0CQk9IGZp
bGVtYXBfZmF1bHQsCisJLm1hcF9wYWdlcwk9IGZpbGVtYXBfbWFwX3BhZ2VzLAorCS5wYWdlX21r
d3JpdGUJPSBleGZhdF9wYWdlX21rd3JpdGUsCit9OworCitzdGF0aWMgaW50IGV4ZmF0X2ZpbGVf
bW1hcChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCit7CisJ
ZmlsZV9hY2Nlc3NlZChmaWxlKTsKKwl2bWEtPnZtX29wcyA9ICZleGZhdF9maWxlX3ZtX29wczsK
KwlyZXR1cm4gMDsKIH0KIAogY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBleGZhdF9maWxl
X29wZXJhdGlvbnMgPSB7CmRpZmYgLS1naXQgYS9mcy9leGZhdC9pbm9kZS5jIGIvZnMvZXhmYXQv
aW5vZGUuYwppbmRleCBkZDg5NGU1NThjOTEuLjgwNGRlNzQ5NmE3ZiAxMDA2NDQKLS0tIGEvZnMv
ZXhmYXQvaW5vZGUuYworKysgYi9mcy9leGZhdC9pbm9kZS5jCkBAIC01NjQsNiArNTY0LDExIEBA
IGludCBleGZhdF9ibG9ja190cnVuY2F0ZV9wYWdlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZf
dCBmcm9tKQogCXJldHVybiBibG9ja190cnVuY2F0ZV9wYWdlKGlub2RlLT5pX21hcHBpbmcsIGZy
b20sIGV4ZmF0X2dldF9ibG9jayk7CiB9CiAKK2ludCBleGZhdF9ibG9ja19wYWdlX21rd3JpdGUo
c3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHN0cnVjdCB2bV9mYXVsdCAqdm1mKQoreworCXJl
dHVybiBibG9ja19wYWdlX21rd3JpdGUodm1hLCB2bWYsIGV4ZmF0X2dldF9ibG9jayk7Cit9CisK
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWRkcmVzc19zcGFjZV9vcGVyYXRpb25zIGV4ZmF0X2FvcHMg
PSB7CiAJLmRpcnR5X2ZvbGlvCT0gYmxvY2tfZGlydHlfZm9saW8sCiAJLmludmFsaWRhdGVfZm9s
aW8gPSBibG9ja19pbnZhbGlkYXRlX2ZvbGlvLAotLSAKMi4zNC4xCgo=

--_002_PUZPR04MB63160EDE1B2FB47D80B717D481002PUZPR04MB6316apcp_--

