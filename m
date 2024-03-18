Return-Path: <linux-fsdevel+bounces-14715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5BC87E4E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 09:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648052823E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 08:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E948286AC;
	Mon, 18 Mar 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FfEDTYp7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gMYZzZKw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8526A25761;
	Mon, 18 Mar 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710750178; cv=fail; b=MNIZNPP5EQ9dIi/jGprtSHFLJ48wiyTOrJNBXaoN3ycPz7mb8TR17U+WX+UtGSUcg1q4s1BbnQYa5djCV6sa2qDXRenqv+4CjN8eXMTX/MJ2YjBQ7VUkq95LlryBzL3TVBYczY6YYfn7A0wIYNN5j9HDcYu0L7Ay1r/ArX6aecs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710750178; c=relaxed/simple;
	bh=kvh5bYj2UOOLlygYWHkLdeqrnvzecXzULgobk+CowwE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ftn8G7yu8RB3/qhBJeCh1XcVbgVv/PXcPl150iMpV/e/XsaF0J8H+Eqv6MjhdIS/3OZguydtCc7TGtYrJ1iaDuM/ynfmec/ByaIe7yjzX4OHhOvDeGgQuUFRE3LOpkbt5DIxL0EjoSjNVoHdGNy7sQeYMNVdf+aL+eMn7ahinig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FfEDTYp7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gMYZzZKw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I1ivQi013876;
	Mon, 18 Mar 2024 08:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OJc1p1mlrvcq9sj36YhT7AeKN+ohSmachMj64NenxFI=;
 b=FfEDTYp7/Sh++7P4XKNMDfdo7oL4PtGf5cdUyOXgkWH6b34LwEYc3Ed33BWsS4E5KodF
 fkcgCHjUIOTYDUKkwp4sUAVB9nvsQ/CQsfCK0B/1hTLtCGf75zzDqdEjJRA0JJmA3L5r
 jxNcgqhkc2QpVQCJJN7S3+nYNvg6NWMa6Gy3KyKXcozZ+vfd9ICL64D855HpZYTbVsZt
 pNJZ30BpxD+4hlMNYEVVowqM1AmnB/0uvGYC8htRrj2YyzEj4Njm7IISioUrKR0NU/Av
 pW0CgGeUqFCLbZq6PdYPUq1i6AyqST92JHP3fROGw2iLSwcPxSdCEVNrY8eoSr1JPK4M LA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3aaacmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 08:22:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42I76M0H007572;
	Mon, 18 Mar 2024 08:22:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v4jge8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 08:22:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZvVnRpbduuldYP6vVeIVyVeFg5jAkT28JzTTMcQ9AsoD/Lf9jeIoByIiKQ5edNQ29jaDqYG6hKMiaNOMt8QF9hCYyfWTH0YA45yIrKoHyhQikLbUbdIqTRMXrEGC9ZfjZWXeTWPw2htg5iR3nFWb8j7/R6g31Yt0bytlOWMXO+UF+tRcMjZ/8CgLlUAxpQamiLFn1fecxBvXtlql1yN0mot6hy74drZpQ3APo5b4iNtDU7nua/uD0H6RXeXbuAMe+LwvkEwsbMSpDvwYFzeJnFYwNXBjy1waYrJoynwe04JLtPtuI+fuMWNPTlh+dcEfTdYSut6nvEUmDVfR2kPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJc1p1mlrvcq9sj36YhT7AeKN+ohSmachMj64NenxFI=;
 b=bpwDGPpBPi+66Y6dYSATgcshRXVlmU8LCO8dQRQUIMsiYNcA6nsklU71adapcOnSxaHY43TLIxCC2S6vEmRxyYi5NSDnDRS7RsKvceEsfmJtJyI7E5KZ+XUAIpBq9kLRE5405ID6rLbklmXULnpilWPbSyVoE4TZue68wQwnHFlnpV0CSt0jod0wGr3/+Q2V/cUQmoEMXhZQ+BXqgeFU3QF+fAasFkMziJY71USQyjmRpEI70DQnoTA4G+zhvj+J2nWJUBChQs8+m/t9XPu/xQru37RY4sxJQCAKfsP3VmMHoXTO3c5PCtVLTmV0G0JJF6dHL/qQ1mNiJ/NKB+DLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJc1p1mlrvcq9sj36YhT7AeKN+ohSmachMj64NenxFI=;
 b=gMYZzZKwEWbkcf4EfDVXFs08Qchfq7efgGhLX/uV93rXWZI7Dpp9yjexI0xY411tEH2Hx8q1/iTOs82TMzxSZYl03AQu44Xv8OqUHnpXlQLIiBXJ616CAqhApgsLSsx6lp98qN90/wOK0VJKRwIuMq5osOQO5uKD1Bnevcmk6Y8=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by BN0PR10MB5093.namprd10.prod.outlook.com (2603:10b6:408:12d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 08:22:33 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::3dc4:7751:97e:42a1]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::3dc4:7751:97e:42a1%6]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 08:22:33 +0000
Message-ID: <22a24d3c-9d0e-410b-a49c-b89d0c00ccd8@oracle.com>
Date: Mon, 18 Mar 2024 08:22:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] ext4: Add support for ext4_map_blocks_atomic()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Luis Chamberlain
 <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>
References: <87r0gcn74h.fsf@doe.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87r0gcn74h.fsf@doe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0192.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|BN0PR10MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fa7458-8ced-4366-188f-08dc4724884f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	d46pMXD/81JWNnbYg04e6ioezls+Fe13xoxuhQA/KRg0g/2BhfVQY1ZLC94k6BBxOo15JBqbwaCTFUjRnnp+412zKNjK50SPcWgBbh7/olS1h6WAJKW9BMPWEiWvi2xbOMO6NtOqFIRfxrJ95YIx0zLKs0fxAUdj8hXiADwgYiW3XpVkMESgSHceP4EFgNEy2T7PjZGRmLw5sfO/QtKAihXsKtlnXROqYVhXEVnAolGJaOzCnq81VufRMWkunQxCuYzPvwqI5S0Nm7rTgf2loUPGL8705FgES4ICffRuWE3Dx/Knw/Tnkh/c7YwZi/k9nkBogCbKeWW1pZRfH6sWHcZrdl3RXApAFFCSYXlG9OrreAMrYpUaNVtgBQdqBTzQLIPqQ3OX/kvrownnqHnFhADJQAnC+PcxgAVlT9WHFM7WSHAV3nT9CzkVC0RviFchkw2bPSuWn3WOIOX1ppcEwpVtMJN13hcrnau6jlRprEJ+CqVKSQwI784QLpxg98nbM384DvTN4H4/y+baDxo1+E+lQ2u/04Q3PqtC2eJqunnYY3wG7AIkLLRXG63Pb0jbSMc59S5kGxGWrl1X9wQt3HdIbynW4ekZSUpmTEsSEZpZyPXG9cRwI0RXWORm+BCP
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VmxvS1JzcnhRQTNTdkxhZ2lCNW9vbmJXZnc2cnA2SGt5SHR4ZDRIZ3pnTFg1?=
 =?utf-8?B?d05Bc29VRjVkaTdSSHFWd0l4NWtjTlVHNXBSb2szZCtGazlJRkJEbEtQQ1Z3?=
 =?utf-8?B?NWVHMTRXYmtzSEZKMjdybWJLWjdOZnliQkxtNTE3U3Q4R2JicWhWdHdNNHVI?=
 =?utf-8?B?dVcwdnBydFk5d0R2RnZoMlI1a0hqS1lwcStlSlJlR25tVmFTcGladFp1Nit0?=
 =?utf-8?B?eSs1bGhKaWdXWHowV1lqNVNuV3RZUDFCbmN6TkZVKzNDMGJvT3pGWUwxYnpT?=
 =?utf-8?B?dWNIT1hjSEs5STdoQVVNaW5nQWQ1ZGtJRm5TWTJadGdudmY5cmdlTHg0dTZN?=
 =?utf-8?B?YkJmMHB2RFlOdFNzSU1LVDBYajBrYWpyVmE4S1lpSlRxQlREZUNWNzhrY08v?=
 =?utf-8?B?Y1NHbmsxeDBOSU1yNVN3UVVySmlPa1ExTVI3WUVDUEUrNkl0Y3NPdXpYRW16?=
 =?utf-8?B?S0huaDRnYWhXeGdsRm0vRDk3d1lRSC9rK2dSZmNWK2JZemtjd2h5Z3ZmUmJ6?=
 =?utf-8?B?VUlEY1ExWmdneGNOdVI4emxlNFVKcnE0ODY0WEwyNUFZTmM4bGFwcFhUam1j?=
 =?utf-8?B?UXpkSlhmYytpanV0Yk16TVhtd1pIQ0xpK2VIa1Y3TjdZcUpXcGxsTlo4WEw1?=
 =?utf-8?B?aUNyU0hGaTFJeHVTcnBmYytldVJLZXI0L1ZYTGdqcXVSSlI5WndpMDVxNTJD?=
 =?utf-8?B?M0ptZTFmMlFXNUVQKzVocFNPMjM1TDY1N2U4UlFmMlZVMjluUVNadHYxN1Bp?=
 =?utf-8?B?c29ORTdTdHFkQmhCQ3MyTFBGL2lrTStZTXZGcGlmODlidDJvM1hEYm1rNE9V?=
 =?utf-8?B?Z3lrcFFYcjlBUGJidXNySXdtbzBDMVlhdTJWM1hmdk16WG1ZTi9uOHdVK2Jl?=
 =?utf-8?B?UW1GYVF4bEVtZ3NlcGVKOXJncHo3VjF6cU8rZkZJeHhRMGVHOXNwSHovY3Bv?=
 =?utf-8?B?TWF1U1FxTmpLSHFTNGU2YmFUWDYzb3g3bk9LNnhZdHBnTXJYcmxWNkhMT2dF?=
 =?utf-8?B?QS8vVTVzdmw1c2ljUkt3Z2lRVmJ0bFl6RXJJNVBFQzNTSWR5UDZzSi92OEFv?=
 =?utf-8?B?V2NmRm9ocUU2Y1A2TWZSK2VCd1RhZ2ZiSlFNZnl3QUVsQ2Faam1wMTA2OGRH?=
 =?utf-8?B?RVd6OGhJZzc0emppV0RpRlZTV2t0L2tERWp4a3oxcVJLM2NKcmhnNmpVbDlL?=
 =?utf-8?B?YXNuWjlHREpmbzZVdlMxcHRXck1VcS9xaGxXTHhvcG1NVFRMbCs1dkpycFNq?=
 =?utf-8?B?eFVIRnVxL0krdGNsTlp4ZHBob2V6YWJhUUNPdmhHUGpjL2w0MXFOVVlJZXVB?=
 =?utf-8?B?cGZRY1dmU2Rmeld0d3lRK2tES3cwVWhkK0pSVHZRbmNoSHg1Q0VTanI2djcv?=
 =?utf-8?B?anNrTkw4cHIvcFNSNGdNQ2FENlN2RVA3NjZkLzdqeVhUZlIxdFdtNGxKWnNR?=
 =?utf-8?B?WmFaY1ZLRE5mSGwzS0RvN3BQUFdiMFVCSW03WnRaMXJxaHRKYzgzZXlRQ2NR?=
 =?utf-8?B?Y1ZvUFU3cTJ2QklWR2VGYURCYWZ5RDBueUtOK2NCa3NTM2p2UkRkd0pwWnl0?=
 =?utf-8?B?dXRJS3E4QXVqQTBSLy9GaDFUV1pzbTVTU2lSMGU0YjltWFFHRkcva0JYUHBT?=
 =?utf-8?B?UjVHelhJOWVvMlY5dWRidmFGeXRmck42TUhEM0VJN1NTME9IeDQwMDh4UkY2?=
 =?utf-8?B?OWFSWjNwbGVhTXJ4ZkNBUDFiUnlYYWZYZ3k5dWMxZmZOL29iamc3VnFDaUox?=
 =?utf-8?B?WXovczBkYVdvQkQvQmtvWjVpa2pKZ0lvd1dRdWw4ZU9sd2pOZVM3M2FITXhv?=
 =?utf-8?B?c201N3phM25XNXp2UmNZMFZ0L3dPb3NmSitqVDR1dkRUMlJQa0daTUo1VGVa?=
 =?utf-8?B?bmY5dGJncTVqN1FNbGRzcVZabllMUEtzSEtlWWpDSzlZSi9wL1JML3l2bU5u?=
 =?utf-8?B?UWlSVFNmYitjeVZqZXRhNzdFbmlYV0hHZW03Vld2V2tCMzdJMlY3Sm5DN0xm?=
 =?utf-8?B?dnk0Y29FYUpUQzFndHdOTW9wVENLNXZ6cFB5NHBCbGU3R3pEYzZGQXhiK050?=
 =?utf-8?B?R0hOanVMUkpuTlpZbVZlYXpyUE5tdWxHWi9hVkNqRTJxTzhna0liL0xKR1ZG?=
 =?utf-8?Q?MnqAPgKidFBtSWkjaqbf2Xu6t?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	a6SjIs3vCbSviNngVL8Y1XPeTIDjmmRZ03Pp64jGb46VmreWNXORqJX4oGyr7AoEEannj1kK0zjyelY7irtchXCZiHCGdNW7mdaQuOJvrwIWfkGxX5j8Q+PhhUG8Pc5ArVmZUh9GcWiBrtufDpa4LVEV2GZu2ZNyFPV+/UECmzDbPQWEeJTSWfRqcCSGhjIKhKweLmpUGkQfaH8QlTHVRnhvueVJkU2fOL9sHFF6S58eWqXbuPK/fvhOS7RyFVQkHeWeZ4CUuF5CItB8iMPl6G0GkvPVVOewROW5q+Enfs5IXzCK8Dp2bCc32w7WRL9CUTxhl4C9e2jcuXAcQFKmt3NBRP2jqo+StpitfshZY26Wz1m239t8vudBL9f9cP8SbPTYzbc3pdqTAetfz8t0wv7W8sgpHP9sLahVq3W7xRwoHabi1d1B73rWRD5PTHtrGPZ9cUe3uV7A+EAVpEVHgWWTCXLqmUiG2uSuxP8p487yPFcR9DKRdjf4k0atA3wakIZioQ2y3iQgHG42yqhQfzvfKR//AMCA4Z+1OGL7Fg25S8eja8qNjs/qWbKlLS3wP3ML1RH6emzbyM5P/3QVUFy/ZX6eoXH11PCCdyicRmM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fa7458-8ced-4366-188f-08dc4724884f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 08:22:33.2366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6LZJyJ1wN1AmV4rnXaTpn1YgCSIsd8gSFU0jP4ZfOs08jV0gJUau+fi0gl/chZxiEww26UtWOZ2bcfNfDTBCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180061
X-Proofpoint-ORIG-GUID: 3Xwjhr8jy25G0GTl6TJ4r9KTj7lr6zgV
X-Proofpoint-GUID: 3Xwjhr8jy25G0GTl6TJ4r9KTj7lr6zgV

On 14/03/2024 15:52, Ritesh Harjani (IBM) wrote:
>> and same as method 3 at
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/cover.1709356594.git.ritesh.list@gmail.com/?__;!!ACWV5N9M2RV99hQ!Pb-HbBdm2OWUIGDFfG1OkemtRSy2LyHsc5s6WiyTtGHW4uGWV6sMkoVjmknmBydf_i6TF_CDqp7dR0Y-CGY8EIc$   
> Hi John,
> 
> No. So this particular patch to add ext4_map_blocks_atomic() method is
> only to support the usecase which you listed should work for a good user
> behaviour. This is because, with bigalloc we advertizes fsawu_min and
> fsawu_max as [blocksize, clustersize]
> i.e.
> 
> That means a user should be allowed to -
> 1. pwrite 0 4k /mnt/test/f1
> followed by
> 2. pwrite 0 16k /mnt/test/f1
> 
> 
> So earlier we were failing the second 16k write at an offset where there
> is already an existing extent smaller that 16k (that was because of the
> assumption that the most of the users won't do such a thing).
> 
> But for a more general usecase, it is not difficult to support the
> second 16k write in such a way for atomic writes with bigalloc,
> so this patch just adds that support to this series.

Is there some reason for which the generic iomap solution in 
https://lore.kernel.org/linux-xfs/20240304130428.13026-1-john.g.garry@oracle.com/ 
won't work? That is, you would just need to set iomap->extent_shift 
appropriately. I will note that we gate this feature on XFS based on 
forcealign enabled for the inode - I am not sure if you would want this 
always for bigalloc.

Thanks,
John

