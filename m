Return-Path: <linux-fsdevel+bounces-25789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB3950641
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 15:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1AB1C21E1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 13:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB2929A5;
	Tue, 13 Aug 2024 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="bAw1+rQl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970319B3D3;
	Tue, 13 Aug 2024 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555107; cv=fail; b=TwJ956UThT165XjTDwtFZsI9PObeMBuz50kkYaBf6+qr9Ke6A2/rdXH+4dSYRGQ4szGYQPLOfd22K/TfiCoINTThaohVojAz2/nVQ4jsYbsplbqkV/dPY79GNszcsH1icmatvjQe2KNjeD6N7lJEEu+8h692MdXEgg+qWcR1CH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555107; c=relaxed/simple;
	bh=LddgduS1Yi9PYQIxMhxv7ydbgoZet/fMx2YxKkV5Kx4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8/KVKoScCARkSb7ceBDQfqUDCsf6rIpCUG/AOrSVVUv8Vj6yFYILAxYiPe7A+pWL3lbagzUAZN6+GV8yUzFdKq0UIyZyUckCIf8aRp86PKDf+sikncl6PcJlkRaEcf18Q9OO+jXI0ho8uOo9in62EGOemRvQOE5CYOMdN/WSHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=bAw1+rQl; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1723555104; x=1755091104;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LddgduS1Yi9PYQIxMhxv7ydbgoZet/fMx2YxKkV5Kx4=;
  b=bAw1+rQlSnH2goa0V3J29WX9+WY6THmieKLQ0hfiPcXk8cU88/i+ZyTr
   h49mlQvAFZevUeNDF8aKfvsb28PXkKdQXHKbV0lOZ3kRGroXKsWgf5Dud
   NjeLFNxSOYFP/3wkxTp4cL7X6tQAGIKYJP9NY6HX5bcvWRzMC9eVSl7JM
   Y=;
X-CSE-ConnectionGUID: /F6tH4q2SryhwqUCNsvRnA==
X-CSE-MsgGUID: 9bOf5ajGT2CYTA4V1sW2iA==
X-Talos-CUID: 9a23:ZDe4bW+K4t1Xa+aTb++Vvwk6RNwFLmSH923BI1ChNE1PU6OvT3bFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3Awj3teA300IssrfMRuiMgXsyLszUjsq6JBh0Ek7o?=
 =?us-ascii?q?64eK1CQUsBW6Gs262a9py?=
Received: from mail-canadacentralazlp17010005.outbound.protection.outlook.com (HELO YT3PR01CU008.outbound.protection.outlook.com) ([40.93.18.5])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 09:18:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7ZqdoMc1BOqt3pHblpOffQSiODtW2JnBG4BJ5ay0oNuhEssA0yg70kj3Bs7191rNu3r5+VR0E64UYZrRQmIC6Let/7dn21e+64q2kGi2XmBlfni3BydtmU5busWsPHkFpvht80tATbao4n4P2XKjv138WN/LiPc5ne5v4rWlx+V3nKwRUVvzkAxubAkaiJNR+JYbdMzPhmQksgi7B40lvJweqPXtSGrxxwOr/xnCBfTcP9jUGWZfncMLvfsBD6PWauzog+wPePrmDcCAMN+R7SvwSWBfhu6zj7U8N3L1es3nmJlAZ+OkqQNdCFwbEkZuikWP3vdRswHQRgWox63jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xc/h6+6amqYMlD+YvtVKnBJFPZi5FsNGgTXhV0Oar0Q=;
 b=NFIvMWFKD/1avmDV/gvXpbqkWYDGRuOoG2wpE/aX7BtFldyzHzJ4vJdfOmwmgfQsvtXlVaQeFjZ8j0yGjskqbWZmAD0ta9KggKHYp6FKulrJxuLE+YzKjKKvgCGIClB471F3lXLJzKL67sZQgtNeHSjQNpCCqz7rgE/iC5nZo1Cl4zJD6a6AmhRLC5BR7D1+U0zYPyIBKR0lkQ6f1w/Uhwwxmxr8fznpm3Y1Nfl8K5R6SWw0i2btBDRpUFAoY6Taya6kvWO5fNwrbpHIyTyldTw/pKxMnvVlDZKxZypQp7Lf08/Z7PHNn1ZpGMseW21i3696aG6QjIlpAnZgnP/lGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT6PR01MB11347.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:139::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 13:18:14 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%6]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 13:18:14 +0000
Message-ID: <6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
Date: Tue, 13 Aug 2024 09:18:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
 amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>,
 Christian Brauner <brauner@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
 Jiri Pirko <jiri@resnulli.us>, Johannes Berg <johannes.berg@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <ZrpuWMoXHxzPvvhL@mini-arch>
 <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
 <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
 <Zrq8zCy1-mfArXka@mini-arch>
 <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
 <Zrrb8xkdIbhS7F58@mini-arch>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <Zrrb8xkdIbhS7F58@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0466.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::8) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT6PR01MB11347:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1bec83-4a1e-43bf-0ae8-08dcbb9a6372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlBtaUVSMnNDb1RJYkJxN1BUbENFZzJtVEtqbDNCYnpsQWM3Y3E3ZFMyN1V2?=
 =?utf-8?B?ZVp0WEhkZEdIUUdRZDZQK0ZJZzM4enJwRnBRVjZiRGlQRzl3Q0Qyb0RNUC9O?=
 =?utf-8?B?amVUVWZNMlFNNUt0dWt2Z0FIbXBmMEw4YXR3enEyditDZXhqLzZIY3Fsa3Er?=
 =?utf-8?B?d1JiWUtjcThoZi9pRjNRQ1RHcGVoNkhsSkhpQkU5N0R2V2NibXFqYVlzdUx2?=
 =?utf-8?B?SkNteENoRDZoYnQxWVo3blRBRWxod01xc2RaZ0t0QWZMQzNQY1dDeUpkTjBn?=
 =?utf-8?B?OC9YR3lITEd1OFdpcnN2ZTdGWmVOc29QQTNuMG5vczdRSWxpWTJ6YVdVaC84?=
 =?utf-8?B?TWpvU2FXRVAwemI4U1lyRlFIYjlwODFtUjVlSGhMV29ZRHliS0J5QWVoaExM?=
 =?utf-8?B?NDNnditZVnprWnQxYXVyNVdOWlpQRTZhZzlBQi9FLzJGYkkrdVJ4d2tvdXFz?=
 =?utf-8?B?cVovNzdhSUlERU9tb1MzdkxhVFNDQThNZDRNcVRvSGpEdkdsN2Q1VU9YakVV?=
 =?utf-8?B?RUNkMHNOT1J0ajFqSW0vVk5sSktOU25DQytuemJ6SDVkNmZKNHpzL2JIT2Vp?=
 =?utf-8?B?N0J2d0NBcG9OcmhsVTZ5cElQaGNkZWpDTjc5UEZVTU1KVWVLUU9OSjVvall6?=
 =?utf-8?B?czMxVURYM0pFU3RoRkxublpZY2FONnlJaTJ2ZnAvbk1JUkVMcGZRcjlDMUxK?=
 =?utf-8?B?TkR2SmtMZk4zcUREVTVsUWNjaENkMlJkMmI3R0k0SjFieHVNRmM5WjVGN2Mw?=
 =?utf-8?B?OVNXYXdjdEpVajVCck1HUFdQZjM4Z0d1WWFYd0F2QWhQODZmVHZESGwwWnF1?=
 =?utf-8?B?UjAxM2RnMUpnY2UvVy9wd1M2VEErOXZ5NmlhcEtSV2hOeDdMYXpBd2oxMDR6?=
 =?utf-8?B?OVMvMnlscTR6M0dycXNtMFhud3NXczlqQTNyTU9nRmowMDhkdnF6dWZMcS9N?=
 =?utf-8?B?T3p5K0lPTWJhL2doNVZUdGVLM1ROWDF0NmRwNjVqVVZJM3phN0M0cVFMMFRT?=
 =?utf-8?B?cm1jWXZLT0JidjN3REdvU3IyVUtYWkswM1djakljN2FNcXR3RTVkTTQ4NzdV?=
 =?utf-8?B?ZnFtUzFhMHZ4ditwQjg3WmtRcmJPemdYMjFTWUtBenFrTi9Ed050SzFJNlRm?=
 =?utf-8?B?dC9QNndmdXc5U09PUjlGRUltMGpSRm9leXBlbkxhUjhnUFQ3ZENhWmYveGNC?=
 =?utf-8?B?MmlGWXVxc1YxbnlIdDNLQXJ3Nk5hZStIeWk0dFY0bWFEbHBWZUl5ZlNVZzMy?=
 =?utf-8?B?TlVEaVZJNnVjdWdTWWF6aEc4QXRhcDFGMEp6ZUFoQUJJRy84UUh2MTJWQUNL?=
 =?utf-8?B?OWtHZFFYNEs4MUhWWXBxMlVvSk9lZFppU1hZbkVMS1NldXJPQnNXcUgzeStK?=
 =?utf-8?B?TWxVcUF6N3grdDl5SHBvOGFTdkpRRXVMVVNEa1FNTk9ETTJlcVlaZ0w0R000?=
 =?utf-8?B?MGdkaGZkT1Z4WXdhMDlRMG5uQi8rWkV5dUtzNUJZcElUTXdrQXRzK25SSUFv?=
 =?utf-8?B?TjlPUkVXdlRrUjRNY2Z0ZFA1NU85emg3WlJPWVF2V2RNaXhrMEVyY0VNYW4y?=
 =?utf-8?B?UGJBcEc4TUdndjNKVDdibEFFUStBbVJYNUpRc282ZnJHbjRYOFFyb1dpcEo2?=
 =?utf-8?B?bVJadTFFNmMreHl4ZDZkaTl0Nm94ZDE5VXhsSW1Oa1Y3Q2duUTNhZHhSQUVI?=
 =?utf-8?B?dXNOdHVPaGVFdURkNUZnazlFQXJwVUtaOTdxbXMrNDhLRmxpb3BqeUFDNDZP?=
 =?utf-8?B?cDhNallJeEFTeEs5cjVzcUxjbEU5VFNER3I1YUxmY3Z0Yy9FTzNIekNsYm94?=
 =?utf-8?B?bWJraGY1OFhnaGx6QTRXZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGhHNlppdDdUbndpYjFueStMNk5TVGJLck1WNGlvbTJIRExlMzZzOGc0VnJw?=
 =?utf-8?B?VGF6cTVBeU1mZ1RNSDdmamY3Qm5oMERXekozQ01LaytpNnNRQnI0V1FLSEd6?=
 =?utf-8?B?cUxOWi8wWUt4K3Rkc3ByekRTY2pNK0pBYWVvSHdkcHdMVDlMUjBYVVdDdlgr?=
 =?utf-8?B?NCtXcXJoR1JtYW9QV3Eza2xLNThhME8wcSt6MGd6MzZDYjJYVGwwN0pxc0hk?=
 =?utf-8?B?T0pCOGZQVDNtVm81am9tVThlam1mb0tZNkJNK1FVd1pBNUk0bENBUTRBdVcw?=
 =?utf-8?B?RmlPR1k1dnlscG8yTGdmZ2NtZS9PVCtHcTV5empvakpPeUhLR2RKcGdaanBm?=
 =?utf-8?B?U1lBODhGcUZpYzJXRUVQOGZlbVNscW5KVGhCV3pkTkJia1lrcjlJeng0Vlp2?=
 =?utf-8?B?T0l5S0Q2M1dBdFJ4TjlBdTJQUDNwUnRVQXdJakYrN3NiSVRwTXloV296Z2s4?=
 =?utf-8?B?UmJTZ1d5bmErWUV1VEV3dGhWbFZyc0Q4bkNOMnRIYnZoRkJGQ3pvbEE0MGZZ?=
 =?utf-8?B?RG5ad1YxNTFHR1dsdnpDUUhKbDZDUFBXV3FLUWo2elpzYnJFa2JjMUF2YjVV?=
 =?utf-8?B?TFJnVEZiM08xaExjSjdDQTZ4ZlZ5VW91dUl0OHIySURmZE0xMTRVbzlZRkxi?=
 =?utf-8?B?ZU9KWjJDSHZsT3IrQTdlZEl6YUVHNHgxZHJBSnQrSmJrQ0pFQ25XWDJMczIy?=
 =?utf-8?B?TkNrUGxKdzIvOGZMYjBpeFg0R1YyRG4wRXNsaHZnM3QyOGdYeU1BRGpjRGw0?=
 =?utf-8?B?OTFnZ0JMWDBYQTVYVEpLMXNmaFBlNHRvZHA4UnY1SHNZODZBTWNlTXpKQzBn?=
 =?utf-8?B?ODRoSklkMHQ1UXpTRm05ZDZOOVRNV0kvcG1YcW1Fbk1yTll3QWJUekxmMUtM?=
 =?utf-8?B?K3pMblFZRUpOaFFjTklzdEVGSnJaWGpld1VrWmlRUFlRNW5Tc1c5UWQ4NVAz?=
 =?utf-8?B?T0pSVXdnYWd6UG9OTEZYZFVQTWJIdHo4WmxYQTRpWWNuZmFGanlHeEtPalFB?=
 =?utf-8?B?dkI4aGFUWWd5SnNzN3RvdkFCT3JkUVZ1WGhjV0dwSHh5SzEwVndreFR3NU9C?=
 =?utf-8?B?RlppdTBNWGJtaS9TWTg4RHNOUm96eElxRG94RXN0NlNuYXArTDVSOExjbmpC?=
 =?utf-8?B?TnhlMkhzVVB2b0RzYUltcG9iRXVGaUpsZiszM2QzRnd0TlFrNE5HanJGMmxG?=
 =?utf-8?B?UWYwT3pyNDZITWY4UVpqVE5QRTBzZnNwK1B0OUZZZ3Vrb0VIV00xaGdZM25O?=
 =?utf-8?B?bm8zNGhncEVXWE9TeEh5VWVnYWR6VkQ2RVh4MGJReStTdjFXUWdvdk9vT2J5?=
 =?utf-8?B?Ym5PaHNDUE5oc0ZyTFRwWUNiSU1wL3lPYzhBT21BVjRnTnJXYjgxVmhQdlM1?=
 =?utf-8?B?TUNwc1RqbVdyUnY1NXNmU1dLUW91OXo1REI2NlRlRmNtekk3NGdTWnFjUGpT?=
 =?utf-8?B?VXorUU9MYW5UcEVDTkhQQXlnZEdxcEpsQ1c3NmVYbDZwSnY5WjBnUk5CdXp4?=
 =?utf-8?B?Y29kc0I0aGNZSnRlbDY2a1hHaThsV0JYaXNaZkpaUlU3NkdoeW9aWmRleTNj?=
 =?utf-8?B?SUl6d1JYT1BGbGtjbCtlT2NqbkN6MkpxSXZta2x2WlNpdFdOamdHUXdQYXlX?=
 =?utf-8?B?TkVjSVl3RGI2YXdiWGd3Ui9KSjlRTkgzS3hpdmZKRnBFcE9RWmtXNVBQTEFo?=
 =?utf-8?B?b2tqRHpkbW01NEVZbXV0a1pFZHFsNmU0bWc3dW1HYWxnWkdOcy90cWNvUmZ0?=
 =?utf-8?B?M2Y2MU9yTzcyWTVaVmVZVUlaV0NTTDRXWW5pckd3UytkYS8vaURwRG4rUzJF?=
 =?utf-8?B?d0xUK1NrU2JSUzV1TzRreHg5bkNXY0pTMW1GeWFBNWxzL2RpNWx5dVpHZUZr?=
 =?utf-8?B?eSswdTE2VS9uZlJiTjRFdkxGRG4vOUVaMFllcklSSmNEVTVNb0pPRkRHTTlV?=
 =?utf-8?B?VC9HUEVUMkRYMlpPWlpsSzlZVzZiRjFhb21nSUFrZzVrVCtNRFl6TUMrVENV?=
 =?utf-8?B?R00vaWY3SnlkcEFnZFhITU9PNnJUejkrSXNyQjB6VkZZWDR1Y01vSVEzd1dn?=
 =?utf-8?B?V3k5NGhsVGNFakp3TkVuL09ZSURKNlBVL0NEZHp1MWdDZS9aVjMyOVRlUW1z?=
 =?utf-8?Q?+RSXHpupyq0NIXvwpPY9cbg6C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uKz4wG2CFzhgFuO0z2sY8E1uKWB10yAFsmuLRkcXHB0Z3W7PpVuc5r13FE0DqT8NnDPkoFGlYKrxzV9Q4JVmlQLZXUiIjH9gaQOWTLC769NA/hyGwywLCdW7SAZa/MdppOjmssZ3lBNr+6jp0dUP5TuVWBc+n+dR7OY39EyhmWZzDtv+SgY90MEn4puGBwy9vDkwm8lQrlCqprf4cqR4DD5X4rfyaCP8dGOOryQXgz9jU1me88If+ceMS6iv7+W0GbNfgem9efKQDZsnIpv5WT00/0qfsxFnvLrBKhe1mAQNRHs+MqFmAtuZDGFugtKYdgaNI7ommd5XpRHD+eeVZ4o1M8nKOJuZcxuvdcswaxuxcJ/zv0hP9BFyOuIzVy4kOVitDoFue++yIWrTFOkDaSZsMr/auPGfcYMmh5ZAxbRW0dCxJjV6R/yF/TVrjAX/EzlF1r+DgtHl+dPioeMrDOkk8Z8DR6nEJJCqMfYGwnHCUbp/u1QwkaGiqfEMh7EWb9nZ4K986I8BcHdgSvszA3mQH1vtWkjGYLygBwshy66zXSrUHgYjpwiDFbkJ08mO4AQwfSGii11e7lsHxzfagyGS9SYG7/7PiYdquNIU0Qw5Ug+Er0dySCMLLNl1OoQk
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1bec83-4a1e-43bf-0ae8-08dcbb9a6372
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 13:18:14.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jmg6z6+ofDooH81MM2I+kB7umob/aT8mi8QodVCQwBLSYVYEQ+5U9A0jxEKEELAhyb9byUY4i/I3pYXxZtb1dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB11347

On 2024-08-13 00:07, Stanislav Fomichev wrote:
> On 08/12, Martin Karsten wrote:
>> On 2024-08-12 21:54, Stanislav Fomichev wrote:
>>> On 08/12, Martin Karsten wrote:
>>>> On 2024-08-12 19:03, Stanislav Fomichev wrote:
>>>>> On 08/12, Martin Karsten wrote:
>>>>>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
>>>>>>> On 08/12, Joe Damato wrote:
>>>>>>>> Greetings:

[snip]

>>>>>>> Maybe expand more on what code paths are we trying to improve? Existing
>>>>>>> busy polling code is not super readable, so would be nice to simplify
>>>>>>> it a bit in the process (if possible) instead of adding one more tunable.
>>>>>>
>>>>>> There are essentially three possible loops for network processing:
>>>>>>
>>>>>> 1) hardirq -> softirq -> napi poll; this is the baseline functionality
>>>>>>
>>>>>> 2) timer -> softirq -> napi poll; this is deferred irq processing scheme
>>>>>> with the shortcomings described above
>>>>>>
>>>>>> 3) epoll -> busy-poll -> napi poll
>>>>>>
>>>>>> If a system is configured for 1), not much can be done, as it is difficult
>>>>>> to interject anything into this loop without adding state and side effects.
>>>>>> This is what we tried for the paper, but it ended up being a hack.
>>>>>>
>>>>>> If however the system is configured for irq deferral, Loops 2) and 3)
>>>>>> "wrestle" with each other for control. Injecting the larger
>>>>>> irq-suspend-timeout for 'timer' in Loop 2) essentially tilts this in favour
>>>>>> of Loop 3) and creates the nice pattern describe above.
>>>>>
>>>>> And you hit (2) when the epoll goes to sleep and/or when the userspace
>>>>> isn't fast enough to keep up with the timer, presumably? I wonder
>>>>> if need to use this opportunity and do proper API as Joe hints in the
>>>>> cover letter. Something over netlink to say "I'm gonna busy-poll on
>>>>> this queue / napi_id and with this timeout". And then we can essentially make
>>>>> gro_flush_timeout per queue (and avoid
>>>>> napi_resume_irqs/napi_suspend_irqs). Existing gro_flush_timeout feels
>>>>> too hacky already :-(
>>>>
>>>> If someone would implement the necessary changes to make these parameters
>>>> per-napi, this would improve things further, but note that the current
>>>> proposal gives strong performance across a range of workloads, which is
>>>> otherwise difficult to impossible to achieve.
>>>
>>> Let's see what other people have to say. But we tried to do a similar
>>> setup at Google recently and getting all these parameters right
>>> was not trivial. Joe's recent patch series to push some of these into
>>> epoll context are a step in the right direction. It would be nice to
>>> have more explicit interface to express busy poling preference for
>>> the users vs chasing a bunch of global tunables and fighting against softirq
>>> wakups.
>>
>> One of the goals of this patch set is to reduce parameter tuning and make
>> the parameter setting independent of workload dynamics, so it should make
>> things easier. This is of course notwithstanding that per-napi settings
>> would be even better.
>>
>> If you are able to share more details of your previous experiments (here or
>> off-list), I would be very interested.
> 
> We went through a similar exercise of trying to get the tail latencies down.
> Starting with SO_BUSY_POLL, then switching to the per-epoll variant (except
> we went with a hard-coded napi_id argument instead of tracking) and trying to
> get a workable set of budget/timeout/gro_flush. We were fine with burning all
> cpu capacity we had and no sleep at all, so we ended up having a bunch
> of special cases in epoll loop to avoid the sleep.
> 
> But we were trying to make a different model work (the one you mention in the
> paper as well) where the userspace busy-pollers are just running napi_poll
> on one cpu and the actual work is consumed by the userspace on a different cpu.
> (we had two epoll fds - one with napi_id=xxx and no sockets to drive napi_poll
> and another epoll fd with actual sockets for signaling).
> 
> This mode has a different set of challenges with socket lock, socket rx
> queue and the backlog processing :-(

I agree. That model has challenges and is extremely difficult to tune right.

>>>> Note that napi_suspend_irqs/napi_resume_irqs is needed even for the sake of
>>>> an individual queue or application to make sure that IRQ suspension is
>>>> enabled/disabled right away when the state of the system changes from busy
>>>> to idle and back.
>>>
>>> Can we not handle everything in napi_busy_loop? If we can mark some napi
>>> contexts as "explicitly polled by userspace with a larger defer timeout",
>>> we should be able to do better compared to current NAPI_F_PREFER_BUSY_POLL
>>> which is more like "this particular napi_poll call is user busy polling".
>>
>> Then either the application needs to be polling all the time (wasting cpu
>> cycles) or latencies will be determined by the timeout.
>>
>> Only when switching back and forth between polling and interrupts is it
>> possible to get low latencies across a large spectrum of offered loads
>> without burning cpu cycles at 100%.
> 
> Ah, I see what you're saying, yes, you're right. In this case ignore my comment
> about ep_suspend_napi_irqs/napi_resume_irqs.

Thanks for probing and double-checking everything! Feedback is important 
for us to properly document our proposal.

> Let's see how other people feel about per-dev irq_suspend_timeout. Properly
> disabling napi during busy polling is super useful, but it would still
> be nice to plumb irq_suspend_timeout via epoll context or have it set on
> a per-napi basis imho.

Fingers crossed. I hope this patch will be accepted, because it has 
practical performance and efficiency benefits, and that this will 
further increase the motivation to re-design the entire irq 
defer(/suspend) infrastructure for per-napi settings.

Thanks,
Martin


