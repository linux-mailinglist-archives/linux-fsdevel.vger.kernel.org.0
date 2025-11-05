Return-Path: <linux-fsdevel+bounces-67222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8E7C382EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 23:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C067C4ECCAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286CE2F12D3;
	Wed,  5 Nov 2025 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="GLio6Agk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC767265630;
	Wed,  5 Nov 2025 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381473; cv=fail; b=ilS4RK84112o7QtS7JUWtiH85yOD/yAYCA8fxPwlie888rfx8v8cgP7lHjdfk7PtdFjCZzLRrv1coTVOyRmJb0ppPbj1XA6Gl4rZaGNB2tKsMbFoSP3pbclzafJt1aaU1Udt2cb2BWuiZOHXbnaQsI6OlkbxFGwPuTBAZi4rVxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381473; c=relaxed/simple;
	bh=HDaXMeMt/+69WbOHDyRKJwbQ0AHXQLIuWyhva5MaA44=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K1AA9zjas1EZbMUbH8HckrkJ1iBHYwFVqk96Qu3Ro1+njotfaxh6wVOP6ZKv97LyMfxnU9TEhiUoeETrBdy2a5izHL+W0pHCjBz+wm6w1/gwmFjyO9iHPgSasCI+umqNmDlxGAam9/yu3iPE4csbtSNprEgYLPZqfQNOYL9ARbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=GLio6Agk; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023118.outbound.protection.outlook.com [40.107.201.118]) by mx-outbound22-92.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 05 Nov 2025 22:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhfb46dqs69DrRi53pDGzPg2EkNL7Zg0m+HsEkuKYbcX7C2tgG48/E92CWyyiCE1TTVCL+Y8g6b4a+j0NEHFTQqI4mB7qVjdxdcWx8jeWwqME6uhHphuCnvCeoIIt/N/wIGIHcLoNLcYOuBmsqt1xsOctytk83odK29hRflVJ9dKhlS3qqj16yL1lznKPULBrF/7YwUZfLSHSB/QuiG+e3cLf5/DLvoPf1xT719EeIZ+TWPFpTH6/WpPHHMc46LwLKF1bNsh+k0PP8o0oLq8nsxpW8Gn8JI//RWNDSrncvg64kL1Aoz7bhqn+zQFB1irmcQQ0EnbNQR/Ul9gCRp3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ0xDLDDEIP2Svj+FGuD4QNGSme1SOi0TsiHiJmTX84=;
 b=HzwIuLPJxWWl+NCq+ksjHdj3geOQpvupZcQrlhjioSAnkPIuJ9eaBgc3xJ+FL+luUcFthUS3wfhlWwR1tA9g57ZIMH6dWdc6j3TgN1JauyN0GR/hFQdTmEaq0JRLEXDhBp9a39Suovm8aBpqoW9YyGCgon13Sjm2H9d2dGn/NLGSyKMUydweCkpj1XN5nW/emLVX/F8NMMpfq4gzIdizh9aSbBPxSDQg9QGeffKS/rP8lvnyT/8jDC71RFM5/gvXMUbImMdtU1hMDc+FKx9ZSKLlXS6SMb6FYn7BtkrDHo3UIe8D2zPZ0TRPP5JvguXQtuw8JAPcVBO61fFY81ZLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ0xDLDDEIP2Svj+FGuD4QNGSme1SOi0TsiHiJmTX84=;
 b=GLio6AgkIFLaYBi+1xgz8YjND9fMdgSfpP/ksoO+l2E2SBupVsQ/rldo9zcj7S3OISlTz/odWrR2QE+NlzIG/+NCmhZOIKvsBqEfJjxtnogfpr7CbnziOOIHAGeXFa6Wrf9gCAbU+wLtksSAqKf/ILs12ciFGzUWzXdVwqjQVVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by CH3PR19MB8125.namprd19.prod.outlook.com (2603:10b6:610:170::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 22:24:05 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 22:24:05 +0000
Message-ID: <7ee1e308-c58c-45a0-8ded-6694feae097f@ddn.com>
Date: Wed, 5 Nov 2025 23:24:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Another take at restarting FUSE servers
To: Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert
 <bernd@bsbernd.com>, Theodore Ts'o <tytso@mit.edu>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
References: <20250731130458.GE273706@mit.edu>
 <20250731173858.GE2672029@frogsfrogsfrogs> <8734abgxfl.fsf@igalia.com>
 <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
 <CAOQ4uxg1zXPTB1_pFB=hyqjAGjk=AC34qP1k9C043otxcwqJGg@mail.gmail.com>
 <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com>
 <20250912145857.GQ8117@frogsfrogsfrogs>
 <CAOQ4uxhm3=P-kJn3Liu67bhhMODZOM7AUSLFJRiy_neuz6g80g@mail.gmail.com>
 <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
 <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs>
 <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
 <87ldkm6n5o.fsf@wotan.olymp>
 <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::14) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|CH3PR19MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 0890bd01-353d-49ea-4942-08de1cba078a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|19092799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlcxS09PaW93Uk1iTm1LKzBWN0ljbmVlZjNtdTlXUEhFMW9ZWU5EQWV0U3ZY?=
 =?utf-8?B?YmVGSDRGbkg2Y0p6R2habGtmUGtoRDg2YzVGeEJ0a204QjdVUjhSQVJqZ2lR?=
 =?utf-8?B?amZKOG9YaFVPVmc2MU1PaGRuK1hTSGFCekxYck10NnJETlozMUREZllDNFNK?=
 =?utf-8?B?Rmk0WkZKWnp6dDZ3ZG9VM1VGdFk3YnhVeUY5V1Y5NGhwL3lOcGlzRFFOQWtm?=
 =?utf-8?B?N0FSb1NaS3daa1AyOWZZSkd1U3dtN1Y3ZE0yay9PZG5UbFhBbHZ0Z0JaSTZT?=
 =?utf-8?B?QnRYRzBwYUxldUtCYk5Ec2ZJbkJhSjJHcDBlZnBjUEFhTVNOVTBwY0hkYkp5?=
 =?utf-8?B?ODlDUjlzQ3JkQU95NVhGQkRVVEtRU05COXNieHE4Zit1YVBYNU9BSk1YaXNn?=
 =?utf-8?B?YklMVnBaODdCd21FdkxEZkNxRlIvaDgrSEExTlJ6V2ZiNWovamJXL256NFA0?=
 =?utf-8?B?UWdOT0IrQU9WekcxWHVqOVQxUXdyazdCOWtmUGU2THhZSjlkZ1VaSzlSMEhM?=
 =?utf-8?B?QzVHSTFWamxsbTY0NEx1VWg2RkVic0tTZ3VpTW4vWXV3L3Z3STVIRFhFNGMz?=
 =?utf-8?B?WVRzeUllcGwydlVnZmNIVmlMa0JvM2pMaUFsSGFOTi9HclIveGxMYks5RWt3?=
 =?utf-8?B?djc3WVBib1hkSEk4ejdpYkNIbHFyRzhoRmxFTVozUlVKMVlFaHV6N0Fib1RG?=
 =?utf-8?B?d3RZRXVsUDVkbjFRdldzRnh0MXhVM2h6aGtQU2txVHNUWFFSUUMrc2c1dUhm?=
 =?utf-8?B?ZERSeU5hMWFaTTgwNFVBS3Azb29tRXZocVZVSmRMUTJkQ3BzWHZ1MTJyNTBw?=
 =?utf-8?B?TVRTOHcrbkVMRkVMYlRDejUvWVE1cjUrQTRKTzNpQmp0TStDYkRPT2tqR1FM?=
 =?utf-8?B?eHloZXp3dUw5bUZjcHNEeHk4RDU2dC9YV2RLK2k0U3RJNGJrdFRJYXRINHFo?=
 =?utf-8?B?US95WW0zS0lpK0ZjYi92dUhCT3JFVm9DeGNtdmtqL2NrT0xhZU85UDBLa1cr?=
 =?utf-8?B?c3hKakN6Sk5qN0tXY2xjNFV5V213N1NaT1pwVUM3MlZPK09YdTd3KzlvMkV6?=
 =?utf-8?B?eE9OSnpBV29POWp3M01TSUdCV3ZxcDNtSmNuK2xvUGZRM2NHMHZFUzZHSEc1?=
 =?utf-8?B?bzJJM3B4L3VuZ1F2dmVMRU40NThrd200RHpIUnZaMVdybytKNENyakRZRGJj?=
 =?utf-8?B?cXR5OW1CaHAzbW1EdFJ5YXRscWJJenoxZzI5N0MxVkl4UWVkejdHRHhzZDcy?=
 =?utf-8?B?ZE5HYnhBL3VUZ1p1M1ZsNGRnNXVHVzk2NVIrOGNKNEFITTFSeG9jWDRkUmx1?=
 =?utf-8?B?c1crcENqd0VlVlJOOGJyTDRqa0JDRHYzdGQ2T01vYzB5OEppazBXUEZzTUZ6?=
 =?utf-8?B?NzZmazhrRTFzTXFMVWJNV211VW84ZVBORERBQk04Y0E1alpPR3pISnljQWlG?=
 =?utf-8?B?S3N4NTRVQ1dhbTVucGNJMHhwdFpHQ1VqNnMxZFljVDVnWWZmS2Z5T3FaVGk1?=
 =?utf-8?B?dk9odXFHREJ1SkRTZFpuc1ZwbDJxM1VLVjhNTEF6MURXZUJ0MDRBWXlMR2lE?=
 =?utf-8?B?dXJZUStqdVMzS1QzeGhoakxLL2lVZ3Q5Wktpb3AwODFXY3UzbGtwcytSc2ZC?=
 =?utf-8?B?NVE0YUxjOElmampvZXFBQjlPeDQxcDlQOWNpSytIWCtqNVVRam1Gc1Y0d3Ey?=
 =?utf-8?B?SlFWYlhwaTEwbTQzMXI3WmtUOVFUSDZ1RkZlWUpRZUIyU1VLWk53MWNmSlRq?=
 =?utf-8?B?dDlTSFQrMFhXeXJnWm9PdWE2dFJHd0NQRzBsSUtYbE50WGcwMSs4UXhlRGFs?=
 =?utf-8?B?djk4U2V2R0E5eXJDQmlyNFU0NWtLdVlYNE9sSGUwVDZwU3VVdUdKdkJMM2Ny?=
 =?utf-8?B?ZUg4QlhRbFlKNm1raWx3K0pNbGVlZTBmajlJVitjaUsxUWl5Mkg2ZFBRaWFr?=
 =?utf-8?B?STAyNXQvZHZOV1ZJWDdidFNjcURlZGtsOHhQbUZiSHEvK0lERDd6KzNuRlh5?=
 =?utf-8?B?VDZ2MGpCMWlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(19092799006)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWtqeFRnTEl0YWR2U1lpWTEveEptUzhZSWl2SHQ3d0g4T2Mwd0NLZkJJU2lT?=
 =?utf-8?B?dTByc2JNM1FxYWVKY2EvbE9KbkFQMDZNQkZ0NmFnUGExRjFhWE4zNXJTRnFn?=
 =?utf-8?B?dytrMU1PeWROaHlGdmxOT0s3cDlVcE5qRk9PWlk3clEvSENYMUFqZWwzTDFR?=
 =?utf-8?B?cmF0OE9URGVOb2tQTFN4U1JFNE0zelBRUlFNU2lKcThFTnZuRU1uSGtmVFFz?=
 =?utf-8?B?MlBUSElhM2t5TXVzY0tvOE1wenQ5cWtMOEZnUTBna0toaDBMOXZ3Z1lCZHN0?=
 =?utf-8?B?R29pdnFMNTdZOGh4dXQwN0N0aHpiSHIvWnJ5Y1N5MEt5T3ZyUHhrOFhBeith?=
 =?utf-8?B?Q3dzVEcreEVVYjlxc0FPbS9zamRmZXpEdi9NUkZuVWJYSzROQ1Z4RnpwdHc2?=
 =?utf-8?B?TmpvTDBHVDJvbXFjQ2lEYmR3REt1dW03WENKdmZaNGpxeWh5WUVVTHBSNTJB?=
 =?utf-8?B?a0paNytKbW10cjd4VUZFa3pPcWJUcVBVMmxCblJJQVdTbkkzbTV6Q1BtMlRh?=
 =?utf-8?B?YUtRajIvYXAzUXdscDU2RXNYQXcweHNjdEROS3QvQm9mc2dObTN2YUxwWG9w?=
 =?utf-8?B?RUFOdW5oRThNVEhBdE5OZzU1c1dEL3l2NnlKeVcxQWEyVVlGZGU2Z1hlRU1N?=
 =?utf-8?B?SlVveHJkUUdWenZMencyd2htK0ZTajd3bFlQOEMrUWNzbkxNNm91eGxYZi9j?=
 =?utf-8?B?S3o2TlE4WFNQUUhoMDNucVlNVmV5OG9zT014dGJEZjFBSWdVNHNQN2E3Z1cz?=
 =?utf-8?B?M0VxQ0NQbkxxajJMeWlsT1lyRFkrZWtzbGNoMndaU2d6TC9JM25URkpWemxP?=
 =?utf-8?B?NURPZGpjQjBWRTViZFV5QUJyRFp5Y0xxNU9EYndOZGdwMmcyTW4waUZFd2FM?=
 =?utf-8?B?MnNKa3R2elJHWFE5VkppZm93SGNRbkNEbVVlYkhod1hSNitKa3U2Qysydnpm?=
 =?utf-8?B?bzF5OS9FWitqRXFWN213NnpmZjBFZTNURm9Jc1g4SytjTHUwN2x0bmZsbUVG?=
 =?utf-8?B?NGJWd3hybHRyWmQvUUZhOVNwaDlJYjlmSCtMWEJaQUNKZUJvQVZNMEMxdmVC?=
 =?utf-8?B?Z3E0VTZLYmwyYmZ0c1RZeWZJSGZaakt2TXdzR2NWNE4xSGtSb1NibWZMNUxE?=
 =?utf-8?B?S3RnNU5Pc0t3aTkxZCtuaUtPWE5SWkZCcDBQWm5FRkVJZFdjQWM2TlhXd1dz?=
 =?utf-8?B?K2lxODNaU3B0Y21GY1pJekVYc3hvRWpOdkJQUUJjY21JSjNGQjdrR0RraXAw?=
 =?utf-8?B?RHMxdE9vTzlPM1gvK3dsTER1QnRYdE80NHlVaHFJdDFKTnFKeFl2NW10Yyta?=
 =?utf-8?B?eUp2WWZsQTRHakhrWVNjOFBySWp4eEdQbHJ4TEp5NWpuc3VOUldBUHNhSE9T?=
 =?utf-8?B?NEZKamNNVWFtdGRUTTlXWGh3M1FBclYxMjJLZGF1N1BUWEdMVW5xR2o5cWJJ?=
 =?utf-8?B?NmVoVkptTnB4MUtqb21MN3F5cDY4aFZ5c29WanB5UFBjdm0rWEF0MUFHNEs0?=
 =?utf-8?B?eFZTdFpIS2NYZHJ6VHBVaWgvdkZKTjNFMVo2K0hNNGJpWEVoNUJkRmQ4K1Fm?=
 =?utf-8?B?YlhNMW1UOC9IZFY2YklVTEkzTFBjK0s5aWUzMmtkd2hVbzFpbzE0UHJkU0ho?=
 =?utf-8?B?eEJRZjdVNFhIR2U2MzlEZFd0bURVZE9LNVJFUkU5OTdRdG5PdDY3Wmtlcmho?=
 =?utf-8?B?dG5kd0NiNWMvMW5DTS9IMHZCYVNLVE11TEJOSURvcm9PdTBSZzVrcHpqWXkr?=
 =?utf-8?B?a3A4SHQva1lGTjNIdmFxSmpXeExBdFpGbmdNTE5wTEF0ZFdkU0NaVzE3QWNQ?=
 =?utf-8?B?d09xRi9jaFM4UFZVdzlwTEsxeUxPWE94TWN1QjdEOFVuRFlxMTJaSUYyaFRZ?=
 =?utf-8?B?djl1a1luNjUzVWt0WnBlZHVIVHF3NHJJNWN0cWIyRC9IaTNKTlhWMFlZemdU?=
 =?utf-8?B?VnljZk5Ua29BVE1xMUFNZ2hKUVY2UWR1Yk1ZcVNLeVZzK1Jqbm5mMm5Gd2Yw?=
 =?utf-8?B?WCtkeUhOWS94Um13WGFUY29RZXNkWENFQWs2WGxrQ2hZR3NIQkJUWkxoY2Rz?=
 =?utf-8?B?cHBLazljN1QyUEloL29Tc0dGQUpoSVhZUlVIVTJrc1pXVDlUc3FXQldvdVNp?=
 =?utf-8?B?aWlNNUtIK09hRHlsZ1NSa0RRM29oMjcvbUlXN0FJR3RTR0ZLV2JYd0laWFpR?=
 =?utf-8?Q?h82YTky4b60e5k17kJSbsM44h/cQ6j6Al8OsdUJUHg8f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x2WF17hj7adkE2GQfbsJjHnVxy9hxTlpDorMJxSEziSh3lu+QMzmlBhTlyYa8YzSzP/0rVcC6UGypPhcX4aQBzPbMh8FliFc/yY7KV8A7iWgm3qgWtpfBNm7ULECcOKvXoNA6gsjMNr2309fP8sr8wJnUjR5N/ou03NFojDVWh/jIgv6foxh0t+8OHH7ZKjBZuKKwPhYgzRWoDe6/ZdnMm5qtELowrlVUC4UYKAVCyYotT1Vm3+0QvnmmrObPRdzYgT6ij62MEmakH+PRkrkrphJ+sTZnyi77rxGjLcURhwSlgNFprheTrHz61ehJPsoRw6BUKXv55N1WaNX/azhPCHJvTeHMVMVJKm7WoJloigE3/0V78+z4D4IubcGC+SJj//tf9n6kS8qzvxTHi/nMFUbK4opA9Uq4kERbdaUpvRS35G3QarTuv6P72xdWfdiTOGdWS650/n0M3BgB5tH5uY8Et+xRMFTWhfM3ZjQ7rqbDGg8fDe3VPsE7NA8dIqdgSDqYyNfAkiXqlhW2hMp2Pzarrul0xfjhq8oKnvCqH0Pjr1wSlaC+iw5NORDFzfJTQ8om0iJH3UjhziCve7qsy480TQrCBlW00nVyiPKzyuky6xXJpran/Jv6PW7+ltxPG9ESjCrqOlsy0W+hT4KgQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0890bd01-353d-49ea-4942-08de1cba078a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:24:05.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMae87CG68ht4da4v1DlnvfRHpFGjM+uAEXC01AJvusT/Pex0JxusmsxrgPTAxdkhj1iTHfKTBxuQ/Eyq7FZRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8125
X-BESS-ID: 1762381449-105724-7956-3568-1
X-BESS-VER: 2019.1_20251103.1605
X-BESS-Apparent-Source-IP: 40.107.201.118
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGRiYmQGYGUNTEzMzUNNXIwj
	QxOQ1IJpknmZmamVimpaWaJVmapqUp1cYCAAfQ6F9CAAAA
X-BESS-Outbound-Spam-Score: 0.90
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268736 [from 
	cloudscan8-95.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.50 BSF_SC0_SA983          META: Custom Rule BSF_SC0_SA983 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.90 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_SC0_SA983, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 11/4/25 14:10, Amir Goldstein wrote:
> On Tue, Nov 4, 2025 at 12:40 PM Luis Henriques <luis@igalia.com> wrote:
>>
>> On Tue, Sep 16 2025, Amir Goldstein wrote:
>>
>>> On Tue, Sep 16, 2025 at 4:53 AM Darrick J. Wong <djwong@kernel.org> wrote:
>>>>
>>>> On Mon, Sep 15, 2025 at 10:41:31AM +0200, Amir Goldstein wrote:
>>>>> On Mon, Sep 15, 2025 at 10:27 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 9/15/25 09:07, Amir Goldstein wrote:
>>>>>>> On Fri, Sep 12, 2025 at 4:58 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>>>>>>>
>>>>>>>> On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 9/12/25 13:41, Amir Goldstein wrote:
>>>>>>>>>> On Fri, Sep 12, 2025 at 12:31 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 8/1/25 12:15, Luis Henriques wrote:
>>>>>>>>>>>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
>>>>>>>>>>>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
>>>>>>>>>>>>>>> could restart itself.  It's unclear if doing so will actually enable us
>>>>>>>>>>>>>>> to clear the condition that caused the failure in the first place, but I
>>>>>>>>>>>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
>>>>>>>>>>>>>>> aren't totally crazy.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I'm trying to understand what the failure scenario is here.  Is this
>>>>>>>>>>>>>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
>>>>>>>>>>>>>> is supposed to happen with respect to open files, metadata and data
>>>>>>>>>>>>>> modifications which were in transit, etc.?  Sure, fuse2fs could run
>>>>>>>>>>>>>> e2fsck -fy, but if there are dirty inode on the system, that's going
>>>>>>>>>>>>>> potentally to be out of sync, right?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> What are the recovery semantics that we hope to be able to provide?
>>>>>>>>>>>>>
>>>>>>>>>>>>> <echoing what we said on the ext4 call this morning>
>>>>>>>>>>>>>
>>>>>>>>>>>>> With iomap, most of the dirty state is in the kernel, so I think the new
>>>>>>>>>>>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, which
>>>>>>>>>>>>> would initiate GETATTR requests on all the cached inodes to validate
>>>>>>>>>>>>> that they still exist; and then resend all the unacknowledged requests
>>>>>>>>>>>>> that were pending at the time.  It might be the case that you have to
>>>>>>>>>>>>> that in the reverse order; I only know enough about the design of fuse
>>>>>>>>>>>>> to suspect that to be true.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Anyhow once those are complete, I think we can resume operations with
>>>>>>>>>>>>> the surviving inodes.  The ones that fail the GETATTR revalidation are
>>>>>>>>>>>>> fuse_make_bad'd, which effectively revokes them.
>>>>>>>>>>>>
>>>>>>>>>>>> Ah! Interesting, I have been playing a bit with sending LOOKUP requests,
>>>>>>>>>>>> but probably GETATTR is a better option.
>>>>>>>>>>>>
>>>>>>>>>>>> So, are you currently working on any of this?  Are you implementing this
>>>>>>>>>>>> new NOTIFY_RESTARTED request?  I guess it's time for me to have a closer
>>>>>>>>>>>> look at fuse2fs too.
>>>>>>>>>>>
>>>>>>>>>>> Sorry for joining the discussion late, I was totally occupied, day and
>>>>>>>>>>> night. Added Kevin to CC, who is going to work on recovery on our
>>>>>>>>>>> DDN side.
>>>>>>>>>>>
>>>>>>>>>>> Issue with GETATTR and LOOKUP is that they need a path, but on fuse
>>>>>>>>>>> server restart we want kernel to recover inodes and their lookup count.
>>>>>>>>>>> Now inode recovery might be hard, because we currently only have a
>>>>>>>>>>> 64-bit node-id - which is used my most fuse application as memory
>>>>>>>>>>> pointer.
>>>>>>>>>>>
>>>>>>>>>>> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just re-sends
>>>>>>>>>>> outstanding requests. And that ends up in most cases in sending requests
>>>>>>>>>>> with invalid node-IDs, that are casted and might provoke random memory
>>>>>>>>>>> access on restart. Kind of the same issue why fuse nfs export or
>>>>>>>>>>> open_by_handle_at doesn't work well right now.
>>>>>>>>>>>
>>>>>>>>>>> So IMHO, what we really want is something like FUSE_LOOKUP_FH, which
>>>>>>>>>>> would not return a 64-bit node ID, but a max 128 byte file handle.
>>>>>>>>>>> And then FUSE_REVALIDATE_FH on server restart.
>>>>>>>>>>> The file handles could be stored into the fuse inode and also used for
>>>>>>>>>>> NFS export.
>>>>>>>>>>>
>>>>>>>>>>> I *think* Amir had a similar idea, but I don't find the link quickly.
>>>>>>>>>>> Adding Amir to CC.
>>>>>>>>>>
>>>>>>>>>> Or maybe it was Miklos' idea. Hard to keep track of this rolling thread:
>>>>>>>>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
>>>>>>>>>
>>>>>>>>> Thanks for the reference Amir! I even had been in that thread.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Our short term plan is to add something like FUSE_NOTIFY_RESTART, which
>>>>>>>>>>> will iterate over all superblock inodes and mark them with fuse_make_bad.
>>>>>>>>>>> Any objections against that?
>>>>>>>>
>>>>>>>> What if you actually /can/ reuse a nodeid after a restart?  Consider
>>>>>>>> fuse4fs, where the nodeid is the on-disk inode number.  After a restart,
>>>>>>>> you can reconnect the fuse_inode to the ondisk inode, assuming recovery
>>>>>>>> didn't delete it, obviously.
>>>>>>>
>>>>>>> FUSE_LOOKUP_HANDLE is a contract.
>>>>>>> If fuse4fs can reuse nodeid after restart then by all means, it should sign
>>>>>>> this contract, otherwise there is no way for client to know that the
>>>>>>> nodeids are persistent.
>>>>>>> If fuse4fs_handle := nodeid, that will make implementing the lookup_handle()
>>>>>>> API trivial.
>>>>>>>
>>>>>>>>
>>>>>>>> I suppose you could just ask for refreshed stat information and either
>>>>>>>> the server gives it to you and the fuse_inode lives; or the server
>>>>>>>> returns ENOENT and then we mark it bad.  But I'd have to see code
>>>>>>>> patches to form a real opinion.
>>>>>>>>
>>>>>>>
>>>>>>> You could make fuse4fs_handle := <nodeid:fuse_instance_id>
>>>>>>> where fuse_instance_id can be its start time or random number.
>>>>>>> for auto invalidate, or maybe the fuse_instance_id should be
>>>>>>> a native part of FUSE protocol so that client knows to only invalidate
>>>>>>> attr cache in case of fuse_instance_id change?
>>>>>>>
>>>>>>> In any case, instead of a storm of revalidate messages after
>>>>>>> server restart, do it lazily on demand.
>>>>>>
>>>>>> For a network file system, probably. For fuse4fs or other block
>>>>>> based file systems, not sure. Darrick has the example of fsck.
>>>>>> Let's assume fuse4fs runs with attribute and dentry timeouts > 0,
>>>>>> fuse-server gets restarted, fsck'ed and some files get removed.
>>>>>> Now reading these inodes would still work - wouldn't it
>>>>>> be better to invalidate the cache before going into operation
>>>>>> again?
>>>>>
>>>>> Forgive me, I was making a wrong assumption that fuse4fs
>>>>> was using ext4 filehandle as nodeid, but of course it does not.
>>>>
>>>> Well now that you mention it, there /is/ a risk of shenanigans like
>>>> that.  Consider:
>>>>
>>>> 1) fuse4fs mount an ext4 filesystem
>>>> 2) crash the fuse4fs server
>>>> <fuse4fs server restart stalls...>
>>>> 3) e2fsck -fy /dev/XXX deletes inode 17
>>>> 4) someone else mounts the fs, makes some changes that result in 17
>>>>    being reallocated, user says "OOOOOPS", unmounts it
>>>> 5) fuse4fs server finally restarts, and reconnects to the kernel
>>>>
>>>> Hey, inode 17 is now a different file!!
>>>>
>>>> So maybe the nodeid has to be an actual file handle.  Oh wait, no,
>>>> everything's (potentially) fine because fuse4fs supplied i_generation to
>>>> the kernel, and fuse_stale_inode will mark it bad if that happens.
>>>>
>>>> Hm ok then, at least there's a way out. :)
>>>>
>>>
>>> Right.
>>>
>>>>> The reason I made this wrong assumption is because fuse4fs *can*
>>>>> already use ext4 (64bit) file handle as nodeid, with existing FUSE protocol
>>>>> which is what my fuse passthough library [1] does.
>>>>>
>>>>> My claim was that although fuse4fs could support safe restart, which
>>>>> cannot read from recycled inode number with current FUSE protocol,
>>>>> doing so with FUSE_HANDLE protocol would express a commitment
>>>>
>>>> Pardon my naïvete, but what is FUSE_HANDLE?
>>>>
>>>> $ git grep -w FUSE_HANDLE fs
>>>> $
>>>
>>> Sorry, braino. I meant LOOKUP_HANDLE (or FUSE_LOOKUP_HANDLE):
>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
>>>
>>> Which means to communicate a variable sized "nodeid"
>>> which can also be declared as an object id that survives server restart.
>>>
>>> Basically, the reason that I brought up LOOKUP_HANDLE is to
>>> properly support NFS export of fuse filesystems.
>>>
>>> My incentive was to support a proper fuse server restart/remount/re-export
>>> with the same fsid in /etc/exports, but this gives us a better starting point
>>> for fuse server restart/re-connect.
>>
>> Sorry for resurrecting (again!) this discussion.  I've been thinking about
>> this, and trying to get some initial RFC for this LOOKUP_HANDLE operation.
>> However, I feel there are other operations that will need to return this
>> new handle.
>>
>> For example, the FUSE_CREATE (for atomic_open) also returns a nodeid.
>> Doesn't this means that, if the user-space server supports the new
>> LOOKUP_HANDLE, it should also return an handle in reply to the CREATE
>> request?
> 
> Yes, I think that's what it means.
> 
>> The same question applies for TMPFILE, LINK, etc.  Or is there
>> something special about the LOOKUP operation that I'm missing?
>>
> 
> Any command returning fuse_entry_out.
> 
> READDIRPLUS, MKNOD, MKDIR, SYMLINK

Btw, checkout out <libfuse>/doc/libfuse-operations.txt for these
things. With double checking, though, the file was mostly created by AI
(just added a correction today). With that easy to see the missing
FUSE_TMPFILE.


> 
> fuse_entry_out was extended once and fuse_reply_entry()
> sends the size of the struct.

Sorry, I'm confused. Where does fuse_reply_entry() send the size?

> However fuse_reply_create() sends it with fuse_open_out
> appended and fuse_add_direntry_plus() does not seem to write
> record size at all, so server and client will need to agree on the
> size of fuse_entry_out and this would need to be backward compat.
> If both server and client declare support for FUSE_LOOKUP_HANDLE
> it should be fine (?).

If max_handle size becomes a value in fuse_init_out, server and
client would use it? I think appended fuse_open_out could just
follow the dynamic actual size of the handle - code that
serializes/deserializes the response has to look up the actual
handle size then. For example I wouldn't know what to put in
for any of the example/passthrough* file systems as handle size - 
would need to be 128B, but the actual size will be typically
much smaller.


Thanks,
Bernd

