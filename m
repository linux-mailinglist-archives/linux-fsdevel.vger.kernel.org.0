Return-Path: <linux-fsdevel+bounces-50618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9D6ACE05B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 16:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67D7169D7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 14:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5767D29188F;
	Wed,  4 Jun 2025 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CPSePQND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454D291879;
	Wed,  4 Jun 2025 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047563; cv=fail; b=Im6gxwdzUb7Rin0BejvUYL+lofMuXSi9+DGhgvPdsnfeEDxYXzIsnFQk7l3Zj8phs3++G6WjF+cOZiopJoSty2WM8JSAo95F3LLAhLJ7JVt6LW+wyTC5e38WLn5lCR1VLDwAvX9RBKKYpM2AkkI0n31HupAmoAighu0JrHbb00w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047563; c=relaxed/simple;
	bh=EXheVudv0HRGP+wqoQehAm6xnzCmFB8qd6Wh8TePLkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YpJfMEMyoCEwtzQ3Obvg5OACeYo2ZrnuElxbS7CUPiABNommSIsO7agQrOe8VVb4IF0seg8cHBbyNkVHqKX9FLeQYG65Lh8ePLgZDspcH4PRLIuIlTYXSmPtNmmCbsDH0DJRW+7ZR+hlznqjJGBazhVHzQJOfSTTa0cAlNhc6mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CPSePQND; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVectBEDn7KAe84wuST3Tir7JMzNDaho+N3PgqUnpLTamINLllsYq6+m4OeDQj2H+dXkR8UA2Tpxmd3Vuddem4YGriH13tdyP30VPYnrIDi9xzdrElPt2LU9Ugt69XDmKd2Yb3gi0n47sIk2OESKGrWofOO8ggVryZz3BZRBU3pq3gaFBSTAGv6qxF9fr8gQ0HkpVCa+qOmpD8a58IhroC6SL9RyQmJB8SILvmz3wGtlmFByrSflkxlS3YQVxN2h0hdTrWwMilpWTopjyWugr8yCE8VRpnXFgu2hybhnKkZqcAiKXsxgOkrvWqFpaqHOTR5sfxDCtHtM4XtCRa48lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXheVudv0HRGP+wqoQehAm6xnzCmFB8qd6Wh8TePLkA=;
 b=wkxe3po7qK3e78uwbcohWAUYYNd1eTkzridsB9zMGAnqf3rSw6knumuadzZjbzdofed+vCgNCtTHkRl8TNsz2C4Z1JWRBaEqxgCtjuQzx73cGA/Q05Zh2jbsc3JKQ2Gk0bMnUUPVQa+UYWYePELgBIsigaqJ2NlM56gQLS5Ig22uYDBs/QyxiNEt7L0NokmBk5PngiWgPNFEdPmDSeS9G9jtLOZZgB5A1iB16vZr1DB5ZqKVa7JrfxU0Oq/ZlvdmPcYTWQl/uvkzfYct4oSYdJIS+99TrTnZ8kSJuq2/yrQUqdC8ZUE1DwiIuIR4d6D6nQHe27Q5TxGmPkxclfcvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXheVudv0HRGP+wqoQehAm6xnzCmFB8qd6Wh8TePLkA=;
 b=CPSePQNDdrdo0vTZqV66EW/1T6JLy9OD8KWOSMpOGVR+rL/e7DSfyAmWiaA8S654COZiy6SsxBer30Fgn9/IoNTpJnjSJ+hA5eNs3oQW7zixAfneLDPkMAlJDjJqBvIEYXb20Cpk4wB/NuFFVW4yN889xmo7820CuaoHCRYQouqRsfKOtVd08dFqfsGiXMu0ROcA5U7gRdzTRSKnqCAOuvLmUSSqOBZwV5sAZFAC4pwO4XQNwCTH8FAadtWPfU9jWs7M9NUAviOe2vAq37Dalj/MbpJWWu0Ii/F6ZyiX2ZHuipPdghLzNeiVfDfGa3XmUCIIXz2Zk2kc6zuYkiuNGg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 14:32:34 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 14:32:34 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jan Kara <jack@suse.cz>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: warning on flushing page cache on block device removal
Thread-Topic: warning on flushing page cache on block device removal
Thread-Index:
 AdvMbvrhAHapLL5SQLSXHQ+FhiQIJwB7b58AACZikZAAAg9cAAAAQBBwAATDYIAAAA6IoAFeHfSQADQ6hYAAADujIA==
Date: Wed, 4 Jun 2025 14:32:34 +0000
Message-ID:
 <CY8PR12MB7195DAD05132B5911B4834C8DC6CA@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <CY8PR12MB7195CF4EB5642AC32A870A08DC9BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <2r4izyzcjxq4ors3u2b6tt4dv4rst4c4exfzhaejrda3jq4nrv@dffea3h4gyaq>
 <CY8PR12MB7195BB3A19DAB9584DD2BC84DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <nj4euycpechbg5lz4wo6s36di4u45anbdik4fec2ofolopknzs@imgrmwi2ofeh>
 <CY8PR12MB7195241146E429EE867BFAF5DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <pkstcm5x54ie466gce7ryaqd6lf767p6r4iin2ufby3swe46sg@3usmpixyeniq>
 <CY8PR12MB7195BADB223A5660E2D029C4DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CY8PR12MB719567D0A9EAE47A41EE3AC4DC6DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <z2qpz2g5wq44ubhuezfv3axwx46btx6bqr4k45k3rs3gsc6ezx@psgsxtoeue2v>
In-Reply-To: <z2qpz2g5wq44ubhuezfv3axwx46btx6bqr4k45k3rs3gsc6ezx@psgsxtoeue2v>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CYXPR12MB9339:EE_
x-ms-office365-filtering-correlation-id: a466ed60-449a-4130-ca66-08dda374a5aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEZqWWpxbkhSQmQ5VWk3eU5mQWRDbnZlTm5na2p3WnlmVS81bUpZdUxldTA0?=
 =?utf-8?B?bzJHQTJHR2c3eWtIZVVmN3owcjNrcGJRam4zTmpIZUtFM0swRnJscWxGZEc2?=
 =?utf-8?B?emU0YjRzR3BEaTFWdzgrY2JBVytGdytyakJUcFJKaW4vL1hOVFFjcHQvZFQ3?=
 =?utf-8?B?RVZ1UzRmRzFHbHY2MFFkR1dNQUZzbFZqM0dLQnlldzZvOHBQQTN4TlhQZTgz?=
 =?utf-8?B?S1BaWmgrZ29DMC9wS0lwdmduWnlOTFBONWNWWEgySFRkT25uM2RlTXhPSzhX?=
 =?utf-8?B?MHUybnl6VTNMakJxd1pmK2c2bnlRYWZQNzY2NEs3RGhzNUtWMmpEU3BUT3M5?=
 =?utf-8?B?clJjemNtT29jQlJ6aG84QTg2YmMvbnlQY0Qyd3ErL1k1RnhKWE45QWhuOGt2?=
 =?utf-8?B?UDFWeGZOclZwTGc5RFJscHNsek9qcnpBNjZhakUzeHZYZFpkYnZoVlh3VjhD?=
 =?utf-8?B?bnhpNVRwak9OUjZ0Tkd3bXRWaEhwUDg3akZlWU9mR216Z3JLTEpFYmJyWWZQ?=
 =?utf-8?B?Y28vdnNRVUhEK3RESzVqUTdDRjRSVkZ4SHh3eGtSL3c3S0VHN3ZINzd1VEM2?=
 =?utf-8?B?bWlJd3cvdUo4T0hkM21Zb1Q5bkJNdzJseml6TjUyRXJ0YXdaWU5zOWhrZmpt?=
 =?utf-8?B?S00yT3N2TXhDRFVWMW9OdjVBYzN4eVRLR1Vyd3E0c3ZYZjg3Uk42QUczMWVu?=
 =?utf-8?B?SW11TDVDejByblltQzdiOXRuQUtxMWd6aENpTGFBS2JQNWM5WGZPWU9RUlB0?=
 =?utf-8?B?dW5sQUtOeS9VT01ia01mZVJPOTN6OU1mN2FQc3lobkw4TUVBNFRhRmVvV3J3?=
 =?utf-8?B?UnVwY1BYMEloRGwvWENjcTVMRmF6Q3hJMmFrbDcxSDM5WVRqc1o4MWNNcVFN?=
 =?utf-8?B?eWpQWlZwTmkrUTRmdGhCWVhiSnMwdDNLeFFNeWU3UzNpSjdnTlJsT1ArNG1W?=
 =?utf-8?B?U1hSUkM4T0lQRWFTcStoSmdLaFRlWVMxMHZ6YW5iWjkxZ0ZBdGtIT2x2OFZp?=
 =?utf-8?B?NzV6c3o5WHNWMDJMeUh1c1A3MENZWmYwNVB1c3dha05WNFFRa2kzTUFhVTZU?=
 =?utf-8?B?RXVmaWZtMm02b0MvWmlXTVphNjB5N3Evdi9WN1QraEpDQnM5VGhsV2c4UXJ6?=
 =?utf-8?B?RFlhTWRXbENtUGFaMm5PYStXVmtDSGFjb2kwWWtram1ibXN6V04rWCs5Zkg0?=
 =?utf-8?B?ZC91bEFpeG40RGs5K3BNaG5yVkk0TkNBZGlxQXJvZXl0elBXVnM4d1oyamdw?=
 =?utf-8?B?SnB1NUJaVjA4MEp4UlowWUhmUzVveU1Mb3hwWk9BVm8rNVZuWXdycGVvYUI2?=
 =?utf-8?B?U3RXbWRCRFByQW1rcHh6dUJQa3JCUThWandkeXBnVmZLVnlJeW55c1NxMzQ1?=
 =?utf-8?B?cDI5RTN4aVBXOTd3bTduK2FMTmxEMGx1S0pOY2dTeXRxYnJxQXpiMVZkY0E2?=
 =?utf-8?B?NHdlakwyNTZidng3M2V1a04rWlJMbEVHYk5BVjRIVlFvcUdWeXc3a3pNdmxv?=
 =?utf-8?B?NTFXQWdoMjZQV0s1UDg3N093MVdHK2dJaGNKcUF0dFdPSXkwVWdzb0NBWXlt?=
 =?utf-8?B?TnJmUXV6aUwzb1lzRStBekx6aER4ZnQrQkYrU3k2YWRNT1JMRmJYd0hsVERs?=
 =?utf-8?B?Unl4bTdqRTVlVlZuTEdzdDh2TFdveUF1OUphRXEydFdUd3FSNXdndTYybTJx?=
 =?utf-8?B?SjR6Q0pTL01NZ1RHMURMY3FDNlYxRURFZUhuRHcvbWpuWFJoUXRYc3NYdEgy?=
 =?utf-8?B?S2ErcGNxVjZpbS85OFpQaGhTMlFFSDI1Vm9uWmNYd3FkRHd6aXM1YjJ1TDRo?=
 =?utf-8?B?NnVHbWl4bytYeFpXa0RUK0hZNjUvSjVZTXJSdkNtSnM5VEFJNlZlUFJQK2tZ?=
 =?utf-8?B?NjdveHRqZGk4ai9HMDJuaFZVb2hldWxUTlpYdzBRY3NmZlc0U0ZNRVE1RE9y?=
 =?utf-8?B?RzE1MmV0Z01NTW50OEc2THFPWWkxZVZSdjZrUWh1YzBSQk4xbXJ0cWJJWkRr?=
 =?utf-8?Q?Eu8FCtDBhCS3Q4It5uq5DaD/otBfz0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGtTK01Ua3BMQVdFNklqRy9QYmtWY0c5OEduRmttOVJNMXVuTHk3RlNwN1ZJ?=
 =?utf-8?B?L215eWpxbEM4U1RtYUxLS0FOSmowMGk0cTVob25KcmZCUHhHZFYxQmYzdTAr?=
 =?utf-8?B?TmthOVkyWlVRWHZhTnRZOElFZXpUaGJSWXBiSm5XSUpHZjgvNHFtRnNBNWhr?=
 =?utf-8?B?MWVaVk9BYzdEejFBVnhGMzkzbHludTNGcnFjQjE2QUpUeE5GMTNzWFhNWU9K?=
 =?utf-8?B?dmFGVm9QUVFUTWVJTlk0ejNTMmF4YUxTWHd4UVBPS1lGQjZyUHExYjNxcGFD?=
 =?utf-8?B?SG5jVHhqOGIrK3FIWlFHL3lmT0UwNW52S3NWVnA0UkVNbURYOGFldHU2MDg4?=
 =?utf-8?B?Nml6Qm4rK0dTVEEwcnpROGxjcTc4eFB0eUtiNnZnOURBZDEvbUY5anZMWEUy?=
 =?utf-8?B?L1FDNkFCeVVSTGdTT2RhWWY0RWJCa1c0SEovZmtFMUxJQUpNRkJ4TUNaM2ds?=
 =?utf-8?B?L3ErNkNEQm1YSWNFbmM2em1lL2loYjUrc1VabzBLV000Ri9BQWJYY3VXTHJa?=
 =?utf-8?B?bGhmMjI5YkRSRXczdnQrdEFESGY3UExSOGppUXhoNzM3RUFicVNnYmIvdmF2?=
 =?utf-8?B?NW5tMFlXWTdXLzFET2w3WklRS1NYU3JKMVF3dzVvdFZQTWNOb1hidE5vcStU?=
 =?utf-8?B?Qjl3OFhKcTUrVm0wZTZKdktMcmFIdTBpR0hJcnp4eDlodGYyak0rZXdTZzZL?=
 =?utf-8?B?NUM2VG5aUmlmQVZleWl3blp2ODlZV0FxTEE0UE8zaGRNaVhtMS9naUQ3bnJG?=
 =?utf-8?B?Mk5JSWszd05pblovcFlNdlRGaHBCY2FqSThFOFF0ZjJWR0pMdnhWZ01Oc1BY?=
 =?utf-8?B?M0ZlaFprSXN0YWZVTmJsQm4rY2poOUVCdVR2cnpORmRzNExVV2Y4Mm4waUU5?=
 =?utf-8?B?Z0dNOWtBa0JkRlpEZjV1cG9pdDFPazByQWc2WktOU0lrdmNyZ0FjTWdUTEg1?=
 =?utf-8?B?NEZJRkZZT3VzK3JUQTZvcjFPTW4xYjY0dEszdE1CRXIrNjhYK2hQYmdBUFpm?=
 =?utf-8?B?Ui9YZUNuNkloSkdycjBlZ1VHeDFjRllsb3pBRDZYYmtJazRmZ0dpa0tWNWll?=
 =?utf-8?B?N21TdWZUWlMyQjk5elF5T3lYSEZVU3IrMHBRdjBSekpEcFlRajY3eE84VXlP?=
 =?utf-8?B?UHJLUHJmRDNxNWxKVDBYVzlTVUsxcjc5UE9CM3VyOU4zQVZZVDBrcEU2Y2gy?=
 =?utf-8?B?Vm5qeEFtZHNQem9ZWk1GdDM1dXlERHNzTk5LbzFTWnkreklWVERPbk5Gc2RL?=
 =?utf-8?B?SStyMzVLTHQ4eUl0UkY0bk9ZT1d3ejRTVDF2dUZBYk9ucDcrR25YZ3F4eFNR?=
 =?utf-8?B?TkhyR2lVcUdJVTErcFZLTi9SVEFUTjd4Ny9hU2RUUnRSckJvRFM0K2RJM2pX?=
 =?utf-8?B?VVc5YkR0TzUzZ1B4dm5EM2dGdXI1aHU0eHh4c1d3UjNyZUJibWxDRGFjMmov?=
 =?utf-8?B?RlNuYkVSbHo1TklZTmtud0hVNUNPTXg1M010NktzNHlVZFhTbXI3YUlDZGR4?=
 =?utf-8?B?T29EWWJGSVBWYzEzQ3JkYXIrQnlzbi9wclByQml4R1hLUkMxL1I5ak1paHZx?=
 =?utf-8?B?bnRlSEdJOFdITXkzdEppYUdzYjNHRTlNRFZzWUlLc04wcC92Z09rRkUyRGxK?=
 =?utf-8?B?Rlp6SmhRSExHbTJqdGxMWGdFWlZMWTJSYlF0RERSUVlCS0QxblpPVm5BOS85?=
 =?utf-8?B?ZlprMlB6czV3MkV0ajd5YmJ2OStKc0l2MDV2cjNOUHhKVVJCb0VmRnh6eWJE?=
 =?utf-8?B?c1lJYTc5UzJqOW9sWmtBaHlMOS9jZEJkanlVNDNFOHRyZXllY3BNQUtvMFBw?=
 =?utf-8?B?czFsNTFvU0o1bU95aWNUbHhKb3hKR0ZETUZsMXczcGxVbkpPQ3RRTHVpVXRD?=
 =?utf-8?B?c3RuT0dSMFUwOTdTejYrMjcvVWlnL2dDUjJ1aXAwVmwxV0VYRlptZEthd29P?=
 =?utf-8?B?MUMzSW9raEk4c1JtM3dKVTJDUER5aXoxQ2xqK25KMTFIZUJPVndBVE5wOGZX?=
 =?utf-8?B?OGQwaXpFcVM3bmxVUW1TRnRPN2szK2g5U09mOEs5dGFxMjhXM2JkMmhlanJ5?=
 =?utf-8?B?MDBLOVRkUlJFQ1VzcU1uY3hSU0FIMUx6SUVOTHp6RExaK3FkZTcvTmMyQzFE?=
 =?utf-8?Q?HMsNDWK4quKn3YxEcRDvuenLt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a466ed60-449a-4130-ca66-08dda374a5aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 14:32:34.7216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1DoH7FxhzUV7G6xe/oEQHTdXeL4fRYUA4txmdzwHA+x7AoIHjnCS6nMzfMT71lAws2rSWq6mq5uH+QDgy880g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339

DQo+IEZyb206IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVu
ZSA0LCAyMDI1IDc6NTMgUE0NCj4gDQo+IEhpIQ0KPiANCj4gT24gVHVlIDAzLTA2LTI1IDEzOjMz
OjAyLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4gPiBGcm9tOiBQYXJhdiBQYW5kaXQgPHBhcmF2
QG52aWRpYS5jb20+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBNYXkgMjcsIDIwMjUgNzo1NSBQTQ0K
PiA+ID4NCj4gPiA+DQo+ID4gPiA+IEZyb206IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+DQo+ID4g
PiA+IFNlbnQ6IFR1ZXNkYXksIE1heSAyNywgMjAyNSA3OjUxIFBNDQo+ID4gPiA+DQo+ID4gPiA+
IE9uIFR1ZSAyNy0wNS0yNSAxMjowNzoyMCwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+ID4gPiA+
ID4gRnJvbTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4NCj4gPiA+ID4gPiA+IFNlbnQ6IFR1ZXNk
YXksIE1heSAyNywgMjAyNSA1OjI3IFBNDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gT24gVHVl
IDI3LTA1LTI1IDExOjAwOjU2LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4g
RnJvbTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4NCj4gPiA+ID4gPiA+ID4gPiBTZW50OiBNb25k
YXksIE1heSAyNiwgMjAyNSAxMDowOSBQTQ0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
ID4gSGVsbG8hDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBPbiBTYXQgMjQtMDUt
MjUgMDU6NTY6NTUsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+IEkgYW0g
cnVubmluZyBhIGJhc2ljIHRlc3Qgb2YgYmxvY2sgZGV2aWNlIGRyaXZlciB1bmJpbmQsDQo+ID4g
PiA+ID4gPiA+ID4gPiBiaW5kIHdoaWxlIHRoZSBmaW8gaXMgcnVubmluZyByYW5kb20gd3JpdGUg
SU9zIHdpdGgNCj4gPiA+ID4gPiA+ID4gPiA+IGRpcmVjdD0wLiAgVGhlIHRlc3QgaGl0cyB0aGUg
V0FSTl9PTiBhc3NlcnQgb246DQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4g
dm9pZCBwYWdlY2FjaGVfaXNpemVfZXh0ZW5kZWQoc3RydWN0IGlub2RlICppbm9kZSwNCj4gPiA+
ID4gPiA+ID4gPiA+IGxvZmZfdCBmcm9tLCBsb2ZmX3QNCj4gPiA+ID4gPiA+ID4gPiA+IHRvKSB7
DQo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgIGludCBic2l6ZSA9IGlfYmxvY2tzaXplKGlub2Rl
KTsNCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgbG9mZl90IHJvdW5kZWRfZnJvbTsNCj4gPiA+
ID4gPiA+ID4gPiA+ICAgICAgICAgc3RydWN0IGZvbGlvICpmb2xpbzsNCj4gPiA+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgIFdBUk5fT04odG8gPiBpbm9kZS0+aV9zaXpl
KTsNCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIGlzIGJlY2F1c2Ug
d2hlbiB0aGUgYmxvY2sgZGV2aWNlIGlzIHJlbW92ZWQgZHVyaW5nDQo+ID4gPiA+ID4gPiA+ID4g
PiBkcml2ZXIgdW5iaW5kLCB0aGUgZHJpdmVyIGZsb3cgaXMsDQo+ID4gPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiA+ID4gZGVsX2dlbmRpc2soKQ0KPiA+ID4gPiA+ID4gPiA+ID4gICAgIF9f
YmxrX21hcmtfZGlza19kZWFkKCkNCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgIHNldF9j
YXBhY2l0eSgoZGlzaywgMCk7DQo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgYmRl
dl9zZXRfbnJfc2VjdG9ycygpDQo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAg
IGlfc2l6ZV93cml0ZSgpIC0+IFRoaXMgd2lsbCBzZXQgdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiBp
bm9kZSdzIGlzaXplIHRvIDAsIHdoaWxlIHRoZQ0KPiA+ID4gPiA+ID4gPiA+IHBhZ2UgY2FjaGUg
aXMgeWV0IHRvIGJlIGZsdXNoZWQuDQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+
ID4gQmVsb3cgaXMgdGhlIGtlcm5lbCBjYWxsIHRyYWNlLg0KPiA+ID4gPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ID4gPiA+IENhbiBzb21lb25lIGhlbHAgdG8gaWRlbnRpZnksIHdoZXJlIHNob3Vs
ZCBiZSB0aGUgZml4Pw0KPiA+ID4gPiA+ID4gPiA+ID4gU2hvdWxkIGJsb2NrIGxheWVyIHRvIG5v
dCBzZXQgdGhlIGNhcGFjaXR5IHRvIDA/DQo+ID4gPiA+ID4gPiA+ID4gPiBPciBwYWdlIGNhdGNo
IHRvIG92ZXJjb21lIHRoaXMgZHluYW1pYyBjaGFuZ2luZyBvZiB0aGUgc2l6ZT8NCj4gPiA+ID4g
PiA+ID4gPiA+IE9yPw0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gQWZ0ZXIgdGhp
bmtpbmcgYWJvdXQgdGhpcyB0aGUgcHJvcGVyIGZpeCB3b3VsZCBiZSBmb3INCj4gPiA+ID4gPiA+
ID4gPiBpX3NpemVfd3JpdGUoKSB0byBoYXBwZW4gdW5kZXIgaV9yd3NlbSBiZWNhdXNlIHRoZSBj
aGFuZ2UNCj4gPiA+ID4gPiA+ID4gPiBpbiB0aGUgbWlkZGxlIG9mIHRoZSB3cml0ZSBpcyB3aGF0
J3MgY29uZnVzaW5nIHRoZSBpb21hcA0KPiA+ID4gPiA+ID4gPiA+IGNvZGUuIEkgc21lbGwgc29t
ZSBkZWFkbG9jayBwb3RlbnRpYWwgaGVyZSBidXQgaXQncw0KPiA+ID4gPiA+ID4gPiA+IHBlcmhh
cHMgd29ydGggdHJ5aW5nIDopDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gV2l0aG91
dCBpdCwgSSBnYXZlIGEgcXVpY2sgdHJ5IHdpdGggaW5vZGVfbG9jaygpIHVubG9jaygpIGluDQo+
ID4gPiA+ID4gPiA+IGlfc2l6ZV93cml0ZSgpIGFuZCBpbml0cmFtZnMgbGV2ZWwgaXQgd2FzIHN0
dWNrLiAgSSBhbSB5ZXQNCj4gPiA+ID4gPiA+ID4gdG8gdHJ5IHdpdGggTE9DS0RFUC4NCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBZb3UgZGVmaW5pdGVseSBjYW5ub3QgcHV0IGlub2RlX2xvY2so
KSBpbnRvIGlfc2l6ZV93cml0ZSgpLg0KPiA+ID4gPiA+ID4gaV9zaXplX3dyaXRlKCkgaXMgZXhw
ZWN0ZWQgdG8gYmUgY2FsbGVkIHVuZGVyIGlub2RlX2xvY2suIEFuZA0KPiA+ID4gPiA+ID4gYmRl
dl9zZXRfbnJfc2VjdG9ycygpIGlzIGJyZWFraW5nIHRoaXMgcnVsZSBieSBub3QgaG9sZGluZyBp
dC4NCj4gPiA+ID4gPiA+IFNvIHdoYXQgeW91IGNhbiB0cnkgaXMgdG8gZG8NCj4gPiA+ID4gPiA+
IGlub2RlX2xvY2soKSBpbiBiZGV2X3NldF9ucl9zZWN0b3JzKCkgaW5zdGVhZCBvZiBncmFiYmlu
Zw0KPiBiZF9zaXplX2xvY2suDQo+ID4gPiA+ID4gPg0KPiA+DQo+ID4gSSByZXBsYWNlZCB0aGUg
YmRfc2l6ZV9sb2NrIHdpdGggaW5vZGVfbG9jaygpLg0KPiA+IFdhcyB1bmFibGUgdG8gcmVwcm9k
dWNlIHRoZSBpc3N1ZSB5ZXQgd2l0aCB0aGUgZml4Lg0KPiA+DQo+ID4gSG93ZXZlciwgaXQgcmln
aHQgYXdheSBicmVha3MgdGhlIEF0YXJpIGZsb3BweSBkcml2ZXIgd2hvIGludm9rZXMNCj4gPiBz
ZXRfY2FwYWNpdHkoKSBpbiBxdWV1ZV9ycSgpIGF0IFsxXS4gISENCj4gPg0KPiA+IFsxXQ0KPiA+
IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE1L3NvdXJjZS9kcml2ZXJzL2Js
b2NrL2F0YWZsb3AuYyMNCj4gPiBMMTU0NA0KPiANCj4gWWVhaCwgdGhhdCdzIHNvbWV3aGF0IHVu
ZXhwZWN0ZWQuIEFueXdheSwgQXRhcmkgZmxvcHB5IGRyaXZlciBpc24ndCBleGFjdGx5IGENCj4g
cmVsaWFibGUgc291cmNlIG9mIHByb3BlciBsb2NraW5nLi4uDQo+IA0KVHJ1ZS4gSSBmaW5kIGl0
IHdlaXJkIGZvciBvbmUgdG8gY2hhbmdlIHRoZSBjYXBhY2l0eSBpbiBtaWRkbGUgb2Ygc2Vydmlu
ZyB0aGUgYmxvY2sgcmVxdWVzdC4NCk11c3QgYmUgdmVyeSBvbGQgY29kZS4NCg0KPiA+IFdpdGgg
bXkgbGltaXRlZCBrbm93bGVkZ2UgSSBmaW5kIHRoZSBmaXggcmlza3kgYXMgYm90dG9tIGJsb2Nr
IGxheWVyDQo+ID4gaXMgaW52b2tpbmcgdXBwZXIgRlMgbGF5ZXIgaW5vZGUgbG9jay4gIEkgc3Vz
cGVjdCBpdCBtYXkgbGVhZCB0byBBLT5CLA0KPiA+IEItPkEgbG9ja2luZyBpbiBzb21lIHBhdGgu
DQo+IA0KPiBXZWxsLCBJJ20gc3VzcGVjdGluZyB0aGF0IGFzIHdlbGwuIFRoYXQncyB3aHkgSSd2
ZSBhc2tlZCB5b3UgdG8gdGVzdCBpdCA6KSBBcmUgeW91DQo+IHJ1bm5pbmcgd2l0aCBsb2NrZGVw
IGVuYWJsZWQ/IEJlY2F1c2UgSSdkIGV4cGVjdCBpdCB0byBjb21wbGFpbiByYXRoZXIgcXVpY2ts
eS4NCj4gUG9zc2libHkgcnVuIGJsa3Rlc3RzIGFzIHdlbGwgdG8gZXhlcmNpc2UgdmFyaW91cyBu
b3Qtc28tdXN1YWwgcGF0aHMgc28gdGhhdA0KPiBsb2NrZGVwIGxlYXJucyBhYm91dCB2YXJpb3Vz
IGxvY2sgZGVwZW5kZW5jaWVzLg0KPiANClllcywgd2l0aCBsb2NrZGVwIGVuYWJsZWQuIE5vdGhp
bmcgcmVwb3J0ZWQgaW4gdGhpcyBhcmVhLg0KQnV0IGl0cyB0ZXN0IHdpdGggb25seSBzaW5nbGUg
YmxvY2sgZGV2aWNlID0gdmlydGlvIGJsb2NrIGFuZCB3aXRoIExTSSBGdXNpb24gTVBUIFNBUyBz
Y3NpIGRyaXZlcy4NCg0KU2VlaW5nIGxvY2sgZGVwIGFzc2VydHMgaW4gb3RoZXIgYXJlYXMgbm90
IG9uIGJsb2NrIHNpZGUgeWV0LiDwn5iKDQoNCj4gPiBPdGhlciB0aGFuIEF0YXJpIGZsb3BweSBk
cml2ZXIsIEkgZGlkbid0IGZpbmQgYW55IG90aGVyIG9mZmVuZGluZw0KPiA+IGRyaXZlciwgYnV0
IGl0cyBoYXJkIHRvIHNheSwgaXRzIHNhZmUgZnJvbSBBLT5CLCBCLT5BIGRlYWRsb2NrLg0KPiA+
IEEgPSBpbm9kZSBsb2NrDQo+ID4gQiA9IGJsb2NrIGRyaXZlciBsZXZlbCBsb2NrDQo+IA0KPiAJ
CQkJCQkJCUhvbnphDQo+IA0KPiA+ID4gPiA+IE9rLiB3aWxsIHRyeSB0aGlzLg0KPiA+ID4gPiA+
IEkgYW0gb2ZmIGZvciBmZXcgZGF5cyBvbiB0cmF2ZWwsIHNvIGVhcmxpZXN0IEkgY2FuIGRvIGlz
IG9uIFN1bmRheS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBJIHdhcyB0aGlua2luZywgY2Fu
IHRoZSBleGlzdGluZyBzZXF1ZW5jZSBsb2NrIGJlIHVzZWQgZm9yDQo+ID4gPiA+ID4gPiA+IDY0
LWJpdCBjYXNlIGFzIHdlbGw/DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhlIHNlcXVlbmNl
IGxvY2sgaXMgYWJvdXQgdXBkYXRpbmcgaW5vZGUtPmlfc2l6ZSB2YWx1ZSBpdHNlbGYuDQo+ID4g
PiA+ID4gPiBCdXQgd2UgbmVlZCBtdWNoIGxhcmdlciBzY2FsZSBwcm90ZWN0aW9uIGhlcmUgLSB3
ZSBuZWVkIHRvDQo+ID4gPiA+ID4gPiBtYWtlIHN1cmUgd3JpdGUgdG8gdGhlIGJsb2NrIGRldmlj
ZSBpcyBub3QgaGFwcGVuaW5nIHdoaWxlIHRoZQ0KPiA+ID4gPiA+ID4gZGV2aWNlIHNpemUgY2hh
bmdlcy4gQW5kIHRoYXQncyB3aGF0IGlub2RlX2xvY2sgaXMgdXN1YWxseSB1c2VkIGZvci4NCj4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gT3RoZXIgb3B0aW9uIHRvIGV4cGxvcmUgKHdpdGggbXkgbGlt
aXRlZCBrbm93bGVkZ2UpIGlzLCBXaGVuIHRoZQ0KPiA+ID4gPiA+IGJsb2NrIGRldmljZSBpcyBy
ZW1vdmVkLCBub3QgdG8gdXBkYXRlIHRoZSBzaXplLA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQmVj
YXVzZSBxdWV1ZSBkeWluZyBmbGFnIGFuZCBvdGhlciBiYXJyaWVycyBhcmUgcGxhY2VkIHRvDQo+
ID4gPiA+ID4gcHJldmVudCB0aGUgSU9zDQo+ID4gPiA+IGVudGVyaW5nIGxvd2VyIGxheWVyIG9y
IHRvIGZhaWwgdGhlbS4NCj4gPiA+ID4gPiBDYW4gdGhhdCBiZSB0aGUgZGlyZWN0aW9uIHRvIGZp
eD8NCj4gPiA+ID4NCj4gPiA+ID4gV2VsbCwgdGhhdCdzIGRlZmluaXRlbHkgb25lIGxpbmUgb2Yg
ZGVmZW5zZSBhbmQgaXQncyBlbm91Z2ggZm9yDQo+ID4gPiA+IHJlYWRzIGJ1dCBmb3Igd3JpdGVz
IHlvdSBkb24ndCB3YW50IHRoZW0gdG8gYWNjdW11bGF0ZSBpbiB0aGUgcGFnZQ0KPiA+ID4gPiBj
YWNoZSAoYW5kIHRodXMgY29uc3VtZSBtZW1vcnkpIHdoZW4geW91IGtub3cgeW91IGhhdmUgbm8g
d2F5IHRvDQo+ID4gPiA+IHdyaXRlDQo+ID4gPiB0aGVtDQo+ID4gPiA+IG91dC4gU28gdGhlcmUg
bmVlZHMgdG8gYmUgc29tZSB3YXkgZm9yIGJ1ZmZlcmVkIHdyaXRlcyB0bw0KPiA+ID4gPiByZWNv
Z25pemUgdGhlIGJhY2tpbmcgc3RvcmUgaXMgZ29uZSBhbmQgc3RvcCB0aGVtIGJlZm9yZSBkaXJ0
eWluZyBwYWdlcy4NCj4gPiA+ID4gQ3VycmVudGx5IHRoYXQncyBhY2hpZXZlZCBieSByZWR1Y2lu
ZyBpX3NpemUsIHdlIGNhbiB0aGluayBvZg0KPiA+ID4gPiBvdGhlciBtZWNoYW5pc21zIGJ1dCBy
ZWR1Y2luZyBpX3NpemUgaXMga2luZCBvZiBlbGVnYW50IGlmIHdlIGNhbg0KPiA+ID4gPiBzeW5j
aHJvbml6ZSB0aGF0DQo+ID4gPiBwcm9wZXJseS4uLg0KPiA+ID4gPg0KPiA+ID4gVGhlIGJsb2Nr
IGRldmljZSBub3RpZmllcyB0aGUgYmlvIGxheWVyIGJ5IGNhbGxpbmcNCj4gPiA+IGJsa19xdWV1
ZV9mbGFnX3NldChRVUVVRV9GTEFHX0RZSU5HLCBkaXNrLT5xdWV1ZSk7IE1heWJlIHdlIGNhbg0K
PiBjb21lDQo+ID4gPiB1cCB3aXRoIG5vdGlmaWNhdGlvbiBtZXRob2QgdGhhdCB1cGRhdGVzIHNv
bWUgZmxhZyB0byBwYWdlIGNhY2hlDQo+ID4gPiBsYXllciB0byBkcm9wIGJ1ZmZlcmVkIHdyaXRl
cyB0byBmbG9vci4NCj4gPiA+DQo+ID4gPiBPciBvdGhlciBkaXJlY3Rpb24gdG8gZXhwbG9yZSwg
aWYgdGhlIFdBUl9PTigpIGlzIHN0aWxsIHZhbGlkLCBhcyBpdA0KPiA+ID4gY2FuIGNoYW5nZSBh
bnl0aW1lPw0KPiA+ID4NCj4gPiA+ID4gCQkJCQkJCQlIb256YQ0KPiA+ID4gPiAtLQ0KPiA+ID4g
PiBKYW4gS2FyYSA8amFja0BzdXNlLmNvbT4NCj4gPiA+ID4gU1VTRSBMYWJzLCBDUg0KPiAtLQ0K
PiBKYW4gS2FyYSA8amFja0BzdXNlLmNvbT4NCj4gU1VTRSBMYWJzLCBDUg0K

