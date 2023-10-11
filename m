Return-Path: <linux-fsdevel+bounces-90-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A31D7C58D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F492824AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7406C321A0;
	Wed, 11 Oct 2023 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vd7YHJsw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I69Ji1Xe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B6F18B04
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 16:06:52 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17758F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 09:06:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BFxBu1004834;
	Wed, 11 Oct 2023 16:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4L5El+al6DsnqFrlBxBnUqahQJV7f5G7lXTG1630r7I=;
 b=vd7YHJswcZedIhCLNwyWrScHbMOCUBLwcWCaQZ0/9O5P8Law+KCkJqRmrkltSg9DBjYL
 s5VmeyoCag9Z4erwx+TlCaTtLNkh2JbUEaWBCn/VEGLDe0y+IrKy30l/zc8qZj5DqVK6
 C/Jb56tV9COnnkVHm+ewEylqTcWKBS2JQWB5K3umgWMGofd0cQ4JKXa3jPIHKqnSUmRV
 nPXtBo84bSMdz3jdyI/aRtq71HXaVq1eWRzFc5mw23JSFUU8tNxJ1eUcdZX2/R2uvCu1
 mB8LgBTDQ93YMGE9iHEUoivVwhW/pkY3IBJ6cAh6sqCznJhjaAuK5AgzEUqqFAnWIvNZ /A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh89wtv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 16:06:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39BF8ZxU028112;
	Wed, 11 Oct 2023 16:06:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws8n3se-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 16:06:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUQt4RNBBB4/ZC8YsEuTv/8ta4Yp9NGneadJI4NHElfsaRLubxJHWzW62oGQFuMs3WO8+2gh6nYD6WsnspQjmfBjW8bZbc5EPgNVW+B0xRMxdZ5luSHakh4tVUtR+DlkHPS+sqLBLo0h1ayLhiowbW6BnjFlSp5Ql3cl4IlHYzrZ9KR5bm0i/h7tVbtMa5NyCzd9X89MCRG56DFYrVSzWrfMZB4oTyLLHq/e3ClTKj4wUZHcfxqHjweq5aCjGQ73Zcc2hSS234Zth58ZhX5yD0mTkX8SlBO+T44LhJToGgxpkytBK2agD13hHfx8723jUUlKpFYgnBbg1HMOFm1CDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L5El+al6DsnqFrlBxBnUqahQJV7f5G7lXTG1630r7I=;
 b=jQGVujcEnecTSEdh9A5KhuvlDBUQFxQgPFGqWZzmwVNCggmZyKutb1rATAIKhZkdiCsuAx51X6QjK721fLX2f3ecjDNq/MJ7xFb4Ypwz+NW7m6FHEeKhuEmgJaU9CoaiT3Jna7Jy4SdEhXu5GJxJhq0bHHDnpiGJYJ+M5CBI+l+4+84cBLu3sqmntmJMWx1sKN/Xf07a357BOSGqjteYy/tLhHVSh5bBL9fJWqOPx1Uo5S9RjceMCFXhAe/535Ee4BJBj11xY/tHGfPrLM6kUNsvlAWSajoiFcV24kj/5/jkFR5Ukn2JetLWz3kTzUKbcr1lDMg8lHejMG1MLenYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L5El+al6DsnqFrlBxBnUqahQJV7f5G7lXTG1630r7I=;
 b=I69Ji1XeiAQ+Rl6++yZQ11sn/SeX+3e463GfttswdbTKuPP4uCSZn/4Z+QhUdWO1E/HOHLjUk8vQMEs2Y3TGUg2EdiZJA1/o+DEZ+yPvv1XySob1AR1CTTtFw+lNn9W8qN8+Tb9qfcCvww2+kD/PG3QuLgT1iCdroogfgAPGJGw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6787.namprd10.prod.outlook.com (2603:10b6:610:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 16:06:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 16:06:42 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Vlad Buslov <vladbu@nvidia.com>
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner
	<brauner@kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: Re: memleak in libfs report
Thread-Topic: memleak in libfs report
Thread-Index: AQHZ/FdqLpZobpowIkSuoIGRXjdgXLBEuAAAgAAFIQCAAAP6AA==
Date: Wed, 11 Oct 2023 16:06:42 +0000
Message-ID: <366CAE3F-455C-47E2-A98F-F4546779523E@oracle.com>
References: <87y1g9xjre.fsf@nvidia.com>
 <4145D574-0969-4FF2-B5DA-B2170BED1772@oracle.com> <87ttqxxi0j.fsf@nvidia.com>
In-Reply-To: <87ttqxxi0j.fsf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6787:EE_
x-ms-office365-filtering-correlation-id: d1de3bd4-e073-4c3f-8606-08dbca740f19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 m0F1bjZYEzW5dKQy/jDwvQe9peMRLP/oT5XOpChS75Z10JjVCL6PW7wlPM1BNkadsPL+RLMwCfhR0GvoiE+pk/r/OH2Cz8Vn1QgX2WO1nv4I/f/FCgJxcJ1RvXRe9Ro3mOXZjuAhYAqkVZM8Y/nv0fkr86FVG3YVorM15sdQGtM828DUSnWlDRTbAaWXSQzqtVXVJSLc1/j3PCzOzBugr5cFAFfDoKef5VQCIDaolH/rppea57ucKbvYeWspqLP7wFQ3AM3E8o+e3KZjXx4xU8GsTBfF4BCKchKb16/R0Qvg+S+MHAag8yumuxKhuYRdWBVibRS19N5jRlNIEmgloBomIyJumdMglB7Q2Gsi7hNc//g7xMlkiD1rOuaOmh2Z866RDb47KbBRWofRBTflkQUHS45i6/c+ZMNs4duAXtqp9ORX2JH0eqNq8edS0ed/SfmMjHLaKZ7R8M54kegS0Dm/eVqgXYPZQqb3UWszbGdxeAVq3pm/H+vgmvuAtqmE2WoHQcoktR+it8LOS1yHVBdImlJTgSTBBX0vKMrifiSyKDUWLhZNc99bkwdic/55+as6vVh+sppZxWnVJwh8Ie+Wob6bdskxyQnaZ3ugjHe3JctOG3quC9UPPHH9Ynr9PpwDRrSyLdb+LHnY+HPUmOLwocKMMCk0u3NtvCjy94s5rwxI8LXpcIfn9FaU0u+/
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(53546011)(6512007)(6506007)(26005)(71200400001)(36756003)(6486002)(478600001)(2616005)(66946007)(91956017)(3480700007)(83380400001)(316002)(64756008)(66476007)(66556008)(66446008)(6916009)(54906003)(76116006)(38100700002)(122000001)(41300700001)(8936002)(8676002)(4326008)(5660300002)(38070700005)(2906002)(86362001)(33656002)(45980500001)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0OAf/336vjxG0jm/uVkeJr5wSwGQ68dy2fEvZ5mbYBRd9iG0L8A7AyQjW6E0?=
 =?us-ascii?Q?HmhvaxGlYd63S97FPtZU/XsYEj69Lm9wL0ND209yxSktZRDGm9LZPgN5ekZo?=
 =?us-ascii?Q?WFzw1/KMPI54mrxe2EDK/O7yfQ0FwRpGhViFYKDe6kmKrJO3cUhVm88zKp0r?=
 =?us-ascii?Q?Biyo40XzHXKTKEOnNTXBsA3AkAZeJMq/u2CIzSNfZKtgMORSpRPRdBG/Te5w?=
 =?us-ascii?Q?buq4//OC4dyI55IF68VBcTjajmsLYpt8s5yOS4/B5BjjBxxW9wl6obiit7jv?=
 =?us-ascii?Q?QSuZ5pErj0a7FN8CTVY886trhEP0ixfsFQavaM7gBrEDY7I/Q2SNnH7WHJFd?=
 =?us-ascii?Q?/qe4TtJc7Bsa+stkf2fxjw7jfvNTcq/kFVnG0Nxd0ryRFh1WIalgE5XVYkvn?=
 =?us-ascii?Q?aLTYHY1suu20aAY+Wc0rskusdOi4G3oeAoKn7tKeE9+/9SnI9QAUQ60poQcJ?=
 =?us-ascii?Q?AlZhTuJRG/2vSyC8uNKIy/QxNEhM21moSwKx8Ch9glQ5UZZhgoQBh/888DRb?=
 =?us-ascii?Q?VaEDa/iugXIBM1GlsX7f9XtOyEtEuqk6BJ3HIOWDke1Brp/pcm4jw5j5oBjh?=
 =?us-ascii?Q?wjbuC8KHOZbyrJ+NvM9oKeT7kVN8so63LeBs3NhTNN5TrB6xnL40WeFvk7zv?=
 =?us-ascii?Q?hHgMiKhtHm3C8AuA4iFnH+RoBYyURmC9wIggJzlYi7W8dkXHpj8KmA+RLEmb?=
 =?us-ascii?Q?/WLwoW+F9TP12n0KQhCAywzKMcsj3MuDIbku773+h5an/Ih+OO16qfK2Ndob?=
 =?us-ascii?Q?g8+5nHVPrEF8MRlIvbqDvgC3ylDpgTmTJiDU1RpJxMaYeOyLR841Z7ZxMby3?=
 =?us-ascii?Q?z8BXQ1E7X7SRALUWIugUnvPn/h547AGI34VG6xxXq7P7tMtw2OfLFwbEApzS?=
 =?us-ascii?Q?hM9SK1CkgRLMNt2q2+ZaFHiL56t6n9p4QhembQpOhxXLT8VoPt/hd5tab7Xr?=
 =?us-ascii?Q?zF8OUP+2UxIXvk4Jlb6WgekMFFgmiId6TM6gAfWgI1D5bVsRZT5FEfgl1ZRL?=
 =?us-ascii?Q?CU4cu2GeLlIx52QvL/6ePwPMjlEjntdjRpXCmlNlzYLt/4OhAk0rgzZm7Sek?=
 =?us-ascii?Q?wjZktcfoIwCWyg2RIGbEcHV+wCi8Ot5YMAlVus4vf4PE9g5hgm/8eFhshWOP?=
 =?us-ascii?Q?Htc06p0vNeFvkIEs/WrL5S4AJTm1PF//WnDsBAiTflDlgkFkoc6cxhijbVqp?=
 =?us-ascii?Q?L916xXgdAT/V2Ao803RHoc1ONQMKtXGYuc37wEZgX9PmIgVkdRDDk7mJEqW9?=
 =?us-ascii?Q?VQpBrmF2b/JYKulLfO/Fwk+D+0c6pVAqDHMD/yjeYtdXjUDDgDBouSk2SQUk?=
 =?us-ascii?Q?ke681k5kYJ2rgPW8X2FPThljwm+TQxiHpCsTMAxu4jOcvLhCOn5Yy0TQxQNj?=
 =?us-ascii?Q?OZdKjVZ40Er4PHkqs0lVb/EfS3J4EV/wnEfX1Ipp1S04G9sbrwROVyBfXUXt?=
 =?us-ascii?Q?iFBCjZtBVCmP+8B02A8zb1X4fCpq2RjYsS6L8dN7igaz8ltjWG6n0bpFjy6N?=
 =?us-ascii?Q?jbhAJfRR7TzVRnynnD0lLVumJzztB3AxSEfISSAxMKmhsaHvobS6yFGt1nj5?=
 =?us-ascii?Q?Q20x4Z08MdkiUMbnXzKk4O9SXvcnB+wFfOvxWsqB2FUZO8rs0n5vVvWsX99Y?=
 =?us-ascii?Q?JA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64E837B246C5374BA526B5AB6572FAF4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3k2HMQteRdc53mda75Brv7W4enmBf4aXSQ7BuoBjSqcoRz0HyltcxweOm5A57lXlGU3w5dllLIf+oEoV6AIe9twoE0pEbOLEOflCQB/c/7KznZbVik428+Rt+kruK2Hy7vBz3qJt3aMIe6L5cPp433VtKcD5gugfKfigc1Gts7IVHv46E/6kL3KS6DBmbQTiAn0uieaCnEPdKKX11NdjQq2juMrTgDR91lg276SUw2pP0U3PGwPxShI3CPkAoEAn0eo4iqUqY/LXLyD92oXHjRIFlgRzZQv+3cfLCLovWhIZDWpVaBMwBQslllf+vMnhv00JTy6noqvqUTCRrl4jHLcYN0scIh9yiD8DNzjD9FfvC8+JRYVUSixHiflrBDPNcERwTOr1qGzVf7oPe7lNG6RAAu+A6wyFrWys7G032spY2FRtegtKcHA2SO2RKRIkNISfaITH1usUxRk9Ni1k0i48px86YrNkQGl+kk3xn3ws8kT+PVGBeWrFwNB9B1gnCFCnHmlYsaDUDqBRGFGYRN4NgROxE2bEcIEL68AJPHSoMM3KupELvsr0ZkJihuG5z/Wjbu1CZ2jvZhLK6is/b3NkiaSEntLE4h/1Ci7HiOgaslIon2G/pGL6hONIV8SF5WnOFDdpmJf3uLqU1NKzZwGfXrMei9qw1HQwo+TtjGQO7FYNASuEG0uRdFafIpbKGnfUzRTDD2bg7+QzreMfmxFztsB1oYxH7wcbG8yoPKuaCjGLiiw3MZ9LJbSJeLhuj4QjzdbI5CiLzcSgTel2FccH8ZKNnSb4e4XCUG5HNxhKZc076oQmB4Xe62kLt1Il
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1de3bd4-e073-4c3f-8606-08dbca740f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 16:06:42.0965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/WXw1feo6dYHofmR4YR9aHosY3X6WIvNExG5asw2kGYvwiF3LnJLVAJBBu8sTjQUDcGSsZ68RC50HjAVkvdmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_11,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110141
X-Proofpoint-GUID: 42eDjVV7sr3y4xaW7z8wWGk_qB5XuEth
X-Proofpoint-ORIG-GUID: 42eDjVV7sr3y4xaW7z8wWGk_qB5XuEth
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Oct 11, 2023, at 11:52 AM, Vlad Buslov <vladbu@nvidia.com> wrote:
>=20
> On Wed 11 Oct 2023 at 15:34, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>>> On Oct 11, 2023, at 11:15 AM, Vlad Buslov <vladbu@nvidia.com> wrote:
>>>=20
>>> Hello Chuck,
>>>=20
>>> We have been getting memleaks in offset_ctx->xa in our networking tests=
:
>>>=20
>>> unreferenced object 0xffff8881004cd080 (size 576):
>>> comm "systemd", pid 1, jiffies 4294893373 (age 1992.864s)
>>> hex dump (first 32 bytes):
>>>   00 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>   38 5c 7c 02 81 88 ff ff 98 d0 4c 00 81 88 ff ff  8\|.......L.....
>>> backtrace:
>>>   [<000000000f554608>] xas_alloc+0x306/0x430
>>>   [<0000000075537d52>] xas_create+0x4b4/0xc80
>>>   [<00000000a927aab2>] xas_store+0x73/0x1680
>>>   [<0000000020a61203>] __xa_alloc+0x1d8/0x2d0
>>>   [<00000000ae300af2>] __xa_alloc_cyclic+0xf1/0x310
>>>   [<000000001032332c>] simple_offset_add+0xd8/0x170
>>>   [<0000000073229fad>] shmem_mknod+0xbf/0x180
>>>   [<00000000242520ce>] vfs_mknod+0x3b0/0x5c0
>>>   [<000000001ef218dd>] unix_bind+0x2c2/0xdb0
>>>   [<0000000009b9a8dd>] __sys_bind+0x127/0x1e0
>>>   [<000000003c949fbb>] __x64_sys_bind+0x6e/0xb0
>>>   [<00000000b8a767c7>] do_syscall_64+0x3d/0x90
>>>   [<000000006132ae0d>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>=20
>>> It looks like those may be caused by recent commit 6faddda69f62 ("libfs=
:
>>> Add directory operations for stable offsets")
>>=20
>> That sounds plausible.
>>=20
>>=20
>>> but we don't have a proper
>>> reproduction, just sometimes arbitrary getting the memleak complains
>>> during/after the regression run.
>>=20
>> If the leak is a trickle rather than a flood, than can you take
>> some time to see if you can narrow down a reproducer? If it's a
>> flood, I can look at this immediately.
>=20
> No, it is not a flood, we are not getting setups ran out of memory
> during testing or anything. However, I don't have any good idea how to
> narrow down the repro since as you can see from memleak trace it is a
> result of some syscall performed by systemd and none of our tests do
> anything more advanced with it than 'systemctl restart ovs-vswitchd'.
> Basically it is a setup with Fedora and an upstream kernel that executes
> bunch of network offload tests with Open vSwitch, iproute2 tc, Linux
> bridge, etc.

OK, I'll see what I can do for a reproducer. Thank you for the
report.


--
Chuck Lever



