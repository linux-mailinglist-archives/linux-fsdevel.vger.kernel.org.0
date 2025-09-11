Return-Path: <linux-fsdevel+bounces-60894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFE3B52A19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 09:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9356A7B583E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 07:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710B272801;
	Thu, 11 Sep 2025 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="FqogRGO2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A9270568
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576025; cv=fail; b=Ng3eMBrxoe8g/oAd2NclkqEDmiKK3i2fJhLLAUJrpuPkS0y+oKj7G77EhBaAlXENu6k1n59ggjL1/mS4BhqmJufIMGJ1oK5B8oeXzanXIYOWLtgUTXGo76LMILHQuYKc9vCifyQa5V53A6Ej+jqqeH9/MjY4mAx0b0SrvHHE+rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576025; c=relaxed/simple;
	bh=FH9n/WA1sM+ciJ3TL2YG0liJAOaPRRqWkcVztxXaLpw=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=bHDGrMrpRDoKTERbjVLpOthvt/R6cCtqYERRHKH00CAsWd4K3HKk5zydYMp7UPKwIrT9h40FX5DtgH1MfiKmB8IW7iqZa1KM0AJGApNp2AIhk/WV6tss+IfKaaj/6dGVY2qQM1DkCHG8enNyt6Ek95EVRC/09oDV1k1OIuwFgXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=FqogRGO2; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2124.outbound.protection.outlook.com [40.107.93.124]) by mx-outbound11-233.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 11 Sep 2025 07:33:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpxMGA99xNWw2PeArQ9/7iOlARs+0STHPw+XhxHChgsmmgMxwB6VXAw0iKbsqhUvzYv+0R0gIRWcHOe3cXXfAMBvTCuqlKn84b1+Io5yD7kIJcZ0nlE2bk6AwKMcoN/ptNMwrBsLy0EU9Z4Y+GE2amNhWcHeNAQvqEaI/qXturWXkfD5gcp3npk5oLLYy7Z/w0uGHhzPAjV+MXlQEGDMmVZQ4wKQNu1oEwXTgLSrqsMHT8ZSZM6J/ldpktHr9XJsK0mwKK1l0JQJhszllPNBsCpe2DA+i7UEmRlGXR3AZAC5MYN2jVV5dgBEK6TkFqYQ3aApaeayT1thC+BoUK3Y8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozsvPYvDSVg+NyIpCCENmFXB9tbL1Dp7+e7xFtTmy9Y=;
 b=wHhvFzAp62I/sOPK7Y/+VhXzfM7Y9AJnF9FCLfD2qAtaL07Fy/Mn0VlusQ7wvOAHDlckc61SrRASCzy5jD+9SuGT2WI1cFvYg4uSCU3YIO/X7oS6uaWmuhIfHD4eXB/2GzoP7TPRBipSOnoqLoxQMWA5VCx7qTe4AqN+KZ/+g+HDHA+P4HlgpmhJBkmVV9N3u2pCFlnkv9sjSXBvcF0U5SSg4RUS5Cnsq91sjzIqzv6Pr11Vzm/RCIyel4gyqZGZKmfiEtDMwJuEQTP2ewjOYw1hBjTiNg9eFiIhgCu8+17KFijiRvtcnr2gLaG5tZZa6aWiTqqyb1Czbf0xVXRbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozsvPYvDSVg+NyIpCCENmFXB9tbL1Dp7+e7xFtTmy9Y=;
 b=FqogRGO2NB2WcS4JfXQZlBzHCCIC8/rhKmyShTjouyLoeABeAPgGgFWHx3FNd73xYkdIKgo5QQSBcbPCDEpE4iPPD/3r0uehKvn5AJ6LkRsEjgMO4TmcBtO84m9yxqBz0rH/sA/sXsufS8nG1EELFWD1vzPssLhBDilZkTBaRkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from SN7PR19MB7019.namprd19.prod.outlook.com (2603:10b6:806:2aa::13)
 by PH8PR19MB7835.namprd19.prod.outlook.com (2603:10b6:510:251::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:33:32 +0000
Received: from SN7PR19MB7019.namprd19.prod.outlook.com
 ([fe80::26a8:a7c5:72e9:43dd]) by SN7PR19MB7019.namprd19.prod.outlook.com
 ([fe80::26a8:a7c5:72e9:43dd%7]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 07:33:32 +0000
Message-ID: <94377ddf-9d04-4181-a632-d8c393dcd240@ddn.com>
Date: Thu, 11 Sep 2025 15:33:25 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu, bschubert@ddn.com
From: Jian Huang Li <ali@ddn.com>
Subject: [PATCH v2] fs/fuse: fix potential memory leak from fuse_uring_cancel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To SN7PR19MB7019.namprd19.prod.outlook.com
 (2603:10b6:806:2aa::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR19MB7019:EE_|PH8PR19MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3e6c96-b3a8-4943-e543-08ddf1058215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnR5WkxtOWxNbXdjc2N0Vi9DRSttY3dXUUxaR2RnYjRzYjFadjJFS1hSVTdh?=
 =?utf-8?B?VCtEVnQzeXRXOWRlVmszLzUwRlJERmRDNnhlZnJ6TU1KaHRtNVN1L3diV0lF?=
 =?utf-8?B?Wmt6ZVYyN3hVa204S1NwbHNSNUNpS2t6TSs5OHU5OG0wRzZWN0FPYlhVRVdr?=
 =?utf-8?B?UjBoMlZrR200WmVtMHN1L0NyTEg0T0srZ2J0eTdPdjZJbzRxQnNlRy95ampD?=
 =?utf-8?B?VFVFSCtEdWVWcTJRaVBGYTZtdjBIbm5CTWw5cTlhQ2VSbmU3R2oybmVIMmtz?=
 =?utf-8?B?c1krWHFQTmFtUWFYdm1xbnRwVjNuWVZFZjNRSzJvVE5EK1FkcTRnOEgrSWMv?=
 =?utf-8?B?YjlFSlJ3ZUNNYWo2Y1RCSWN2TlJxeWNTcmJhYXRwSXd1M0dhS0pBOTAxeFR0?=
 =?utf-8?B?Q2phbWV6dnlIWDZVQXk1cERHZ0tBQkFXdXpyb05DYjRrakdQcy9OdmczY2NZ?=
 =?utf-8?B?OENPMk1rRzFkV09kK1lubUtPYWpBQVdNalkxMmprNjIvZUw0S2NHb2ppMUQ1?=
 =?utf-8?B?M1NvSGZ1NTNtL25lWHd6TUcwd3pIK1NzMEpWQlNnc3pvN25GZGtMNFFTWkJ0?=
 =?utf-8?B?Z1NkOEp0aDA3THU1bjF6NTY5VFUvaG5yZU5sTmdldkNwdTd1QTBnQ0pkY3dn?=
 =?utf-8?B?cmpKbkhKcnZjbHBOSkxtWEdiNG1VeDJTWVlKQU1ybVVZeGlyWlk3aWdyZFIv?=
 =?utf-8?B?ais1akgrZEVYeUplcEQzWlZnOGptTnppblYxWWNud04yOFRxVXNHSXlwc3Yz?=
 =?utf-8?B?TjF6UEtGLzBWYXFNUExHUEZxVFU5TFBmb1duVEU3TmJvckRlRzZsblQ0YjlO?=
 =?utf-8?B?Z1poWXRvckh5T3Zha0FrZlN3SXdDa1duYlY4U2l1L1RxTnliS1ovTHR0MDZH?=
 =?utf-8?B?MkhpWnNYWWdRQmFQVmk2TTl6d0NwTUllUkRRL0xoMzhKUHpXS3RSTkl1V3ds?=
 =?utf-8?B?bHpPRlFWOHR1TWNEaTlNWVBtWFFmSHh1VHVVcWpodVdOMGVjQXVIVjF4cDZW?=
 =?utf-8?B?eTBlQXQ1OXJla1Y0QWZEaFkvTk5OMitPaWo1TXVoV0RsY05MOHJjOGgybWdj?=
 =?utf-8?B?Z3BFMFNGYnAxMHpqSHZXOHBiRldLdkNpTnA2ZlFEZ2xpcUZUOWo2UTVLWU5n?=
 =?utf-8?B?VzVPaVFqMVBSRGdFT2t0cXdNaU9FWXc0ZzFSUlhhK1IxWnZwZ0FXaFVYMTBh?=
 =?utf-8?B?RTFERTUxSmlNTzRBdVlQZWFlYVhOOVdjU0o4UHlEYXJFWDdjaVVmQVpwbWtw?=
 =?utf-8?B?UXlGOXRRc25LTEdIZHVpdmc5WCtYOThpOWlXZHFVSmJZekhta3FWVk9reURM?=
 =?utf-8?B?WUhBbnNBNjEyQmF4ZERGWHpLZTJ3U2VwMk95eWtFMCtyYTVxZ2RJRUg3WXNu?=
 =?utf-8?B?ekdFb3JLVEx1UUh3STVhVkxGV0lJb3g3WDdlaW1yWHB0YzZHNTg1OXYxRjc3?=
 =?utf-8?B?SG5ZTDg5RDBZMzhManNublErWTF3RklEc1ZmaHNNVnppTXh4MjRFa3B1TG9i?=
 =?utf-8?B?SE5LalphK25nVlphNHdvRllDdG9MMXE0bFBaaEgzS1huQ1BBTE1EcWZidlZB?=
 =?utf-8?B?Nkt1RXB3V244aEgyYUxwTzhBczJDTmNuakxKeTdmWFZ1a1kxT2Q0Rm5oeUVn?=
 =?utf-8?B?cG1WbVduTWZRcmE4Nm1XeFRhWGp5YVJvUVVlRDFoQkdmKzFKU2gwSzl1UTQ0?=
 =?utf-8?B?NzJWZ0hsd0dlUHNsR2FBeEtZWlI1ZHc5dmNHOW55MkkyVW9nMjVhZXp2YkhL?=
 =?utf-8?B?a2luVjFqNTczUG1LT1o3bXlSSXlkZjlQb3JwMEMxaXphdEZjRCtxRnFvdVRZ?=
 =?utf-8?B?T1l3cWVlSE9OcENzc0owOHN4aVdmOXZldUFFbmxDL2h2Z0l4THM0MnpiNmRO?=
 =?utf-8?B?UlB1TFlGOWxtU1FST3pJbDQzZUNNUFlPQStnNnYwa3pyRHhHZjR5Z216VVVC?=
 =?utf-8?Q?e6OZcd62/4s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR19MB7019.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVA2TUVxRDlxaklyZjJVOEcvb0xaMGZXc2Fva0dFQWlNUUIzeFFuZktlSy85?=
 =?utf-8?B?eDVTK3V1aGxtWThvUktSakszSnNsc2RDbk41dUZMK2dOeWJYQ01PT29HRjdP?=
 =?utf-8?B?ZTZwbThnVVVmRXJrWXJSYlc0VTRxeW93OWh5dml3ZUtwM2RtT0I4RE5pOU5P?=
 =?utf-8?B?aFI0b0p3emU1RFhnSkFxQkNwZHJvemJUa2hFUVl2bXBjSWFJV1M1UXg4UHZ2?=
 =?utf-8?B?Z1YrUEN6cUtSUWl0ZkVLTHdOUG03VjRqbHp0K01PaS9yemVDVlBpSVFvUWZr?=
 =?utf-8?B?bUY3NjhQY0tFbmJCNFU4K0NkZzZXdUpqYThEcERabTlFNVpSQ3dYeHo5aUJD?=
 =?utf-8?B?ZlFVMUxFdmZQR3ptblovRU5Yc1RORi90V0VFekJtK2pEWlh2Z05ORU9OVGV4?=
 =?utf-8?B?Z3RPbUdZeGhuYit2TUtGblE1Nk5lVk8vS0NLY2VoTHhVc0xmQUYzTjBqcE0x?=
 =?utf-8?B?MkhjaTF4eUpTa2Z0SVFCbEdyQi9CL2doZVI0TzJDQWZPNFVmMXJsblkvVWow?=
 =?utf-8?B?cWhnTHkvd1BXRFJrZ1NrbWpEN3NsdkdvSThTYjBGQXU0VGEzZTE3UlhzL2lY?=
 =?utf-8?B?YWFhQkRER3UzZzRHTmU5UDliOWRVQm82aExoWStHblZjL3FESjFyMG1jcEpD?=
 =?utf-8?B?Nkp2OExFU1FjQkJZOEl3Wm1tcnhJS0ovakhEc2FGUGZOa2w3ampYdU9GYlZM?=
 =?utf-8?B?di9UdFdpaTF0S0QyaWpidU8vZkJPSUpWQzIrVzViblpkYjFqNnY5M3psNmFV?=
 =?utf-8?B?QU9YUnFTdmR1YlJmUXV2ZzVBemFoL2gvaUQ5bkJoamRFd1pNRGIzZGc5Kzlt?=
 =?utf-8?B?S2JrS05sbGUwSFl0SFZ0dWhUdlpIM0hpYkFDZjRFVUhiNjhOYU55MXJOWkdS?=
 =?utf-8?B?UnJoNENUZmlyYU9XbFZGVFpjZzJpZC9pL291QWtjc2dFb01waVJKaHp6QzdP?=
 =?utf-8?B?K3BJYlVIODNpai9TUk1DckhXRytCWFlZVlh0RVRIQUdDbWMrdTZXSUVIRmtF?=
 =?utf-8?B?WklZekdXTTJvN2k5YW56NXNxYmNXYldxdzJPUUZiOGUyQ1I0QUVQanZsVTVk?=
 =?utf-8?B?MUxQYUN6VWk4bXdOTjFCbXJZZ0lRRW5KeDVhdlJrdnZEVldvVkZ5YzlXSDBq?=
 =?utf-8?B?aTA3QmpLRE43QXcraFVPVVlYUkpuQjBLSC9POGpLSG9xdld0bFRuWWdhdUI3?=
 =?utf-8?B?UjFzam1EWEpBVjRlK01PQkZUQkpsSXpOSVA5VXJXaHFMZjVVU21uWGhEdW80?=
 =?utf-8?B?emxIV0tCMy84V0pOZ1hzYnkrMFNCRjlaUnNiQzA2Z0Y2YzNBUzdKZGt4RGRG?=
 =?utf-8?B?aFA4dHR3Zy9GcS9OTE0ycXpsZGo4R2VuajU2Yjh0eTZTc3NtQzd3cjBhcHVI?=
 =?utf-8?B?WVBOS08rZ1FkSXdiUTF5Ry9DU3o5K2MweXR3ek1PTHZYZjNQWjNYQXQ4blBJ?=
 =?utf-8?B?TklsU281SWFmN0hYNjdyQzhyeEhid0VRVUc1a0hnT3prako3L21wcFN3TU5H?=
 =?utf-8?B?SlAvY05VK2I0L1oxVENSaWQyV3dJbEd2QnZIM2NtR0tNT0tLWjNtL0tiZFhG?=
 =?utf-8?B?N0Z3SW0wRWkxemVLbTBsR0gzdVRMSlZxbFp4aXFXRWdwbi9QY0N6Z1pxNEgv?=
 =?utf-8?B?WnlYQmxTcEdMa0VvZ05HTmpmY2hCYkx2WmM4Y2xYZkhPUGxmZGlhR1pnSUVP?=
 =?utf-8?B?TmNNWlNycE5jTExpeHhmQldxc3BkeDJibExOR0FqSUFFY21zTWxDYld2azhF?=
 =?utf-8?B?a3FLdG9lSVRiVTFtUTJqZEkzRkxCTVdtNmZRMVpuOFBGVnBWVjZaanhzYm9L?=
 =?utf-8?B?WEVDdExrRU9DVXFQQUR6T2ErUkovV0RRS1g5YUg0VlhIK256TXRMZnRNZ1Jv?=
 =?utf-8?B?L1o3OGtRR1IxR0pVQkVhWnc1N1hmb3h0UEFqZHRXR1ZQUEZmYVJNOUpNOFJP?=
 =?utf-8?B?M3l6eFlaY2dVcmtkSG5iT09jb29IQk8ySGRnd3EzVTVlMXc0WUVqSGZIaFM2?=
 =?utf-8?B?MVBhaDBadE5MUEx6aVhtU09WeHZicTVjVkFyQjE3Wmp3WVBCRGVYNXBLbkZK?=
 =?utf-8?B?ZnlUTkVuSUVQdFR6enB4SHNaNmQyeFRmeWg2aVA1Q0dRMzNYckhMK1I4R2FF?=
 =?utf-8?Q?GD18=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1Mr6jw4a+O8xah9yWaXRXB70VymDOQ7JKd9CRd8+aBOh8NqNFDummkCpaYXP8lqBF3xuVaJVmUvdOhkpodlTAHlKOZe7hb5zzpQFhAjWZtehknt+eJnFVmc5smUtGc4orBBiiIuPu6VqUAGQWiChB6UHPuz8RJjv5reaFFsKFkEFj+VhV2cXLgKO6GzJaYV2kb0iWRKbzKDstRL968UD6fy20iyEdVVT7tw/Mj5RoiF5O+T7oTirYkkxTgF8pyRCvpRihXf9KbaSHeMDQ58KavjnkgE2YqLNXuz+2pdsXGnBXX+p4/lnb35aJFtOA7Hpk4/LX9kBS6g1e+tdvpa0Q2zrqLQmidDDI3Ybt6fvmYW/3ehuDA5DqW7GiV/noYWVYodgToHNXswZMMVNtQ9cK9iz6r1819Mzz+QmXKarJnhmnK+fzU+Tij9HW/vE8usCeMo0MRLQjfiC1HwAwZcUBEq1sGh2uio5R+R9VsDJK5y2WvQVXQ/QnBTITiE5AHyyHCzxo1CpIIKSL5rJvy9T9MWllbWZr6EFfYqjuMaqS549ezEaXTkh1KDTdQmIyM6nXJLwc7Zlhh5+ENqtX/j6nx4Np84Z1wNsz084PF/cgQe3GxCyt7hOdpD7gkO28OTqcsMR3XpFOHjMv30vfYwHTg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3e6c96-b3a8-4943-e543-08ddf1058215
X-MS-Exchange-CrossTenant-AuthSource: SN7PR19MB7019.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:33:31.9547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmdqgAF/7c1GCkXyYAsC5kLvcJPPYB69IqUUVg4Y9f8V9azN2dRSgP3l1/bonTKQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7835
X-BESS-ID: 1757576015-103049-24366-14158-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.93.124
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWZsZAVgZQ0MTEyNIiOc08xS
	zZ0NDc0NAoKcks2dTQ0jDVINkoJdlMqTYWAAEL6lNBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267400 [from 
	cloudscan8-206.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This issue could be observed sometimes during libfuse xfstests, from
dmseg prints some like "kernel: WARNING: CPU: 4 PID: 0 at
fs/fuse/dev_uring.c:204 fuse_uring_destruct+0x1f5/0x200 [fuse]".

The cause is, if when fuse daemon just submitted
FUSE_IO_URING_CMD_REGISTER SQEs, then umount or fuse daemon quits at
this very early stage. After all uring queues stopped, might have one or
more unprocessed FUSE_IO_URING_CMD_REGISTER SQEs get processed then some
new ring entities are created and added to ent_avail_queue, and
immediately fuse_uring_cancel moves them to ent_in_userspace after SQEs
get canceled. These ring entities will not be moved to ent_released, and
will stay in ent_in_userspace when fuse_uring_destruct is called, needed
be freed by the function.

Fixes: b6236c8407cb ("fuse: {io-uring} Prevent mount point hang on 
fuse-server termination")
Signed-off-by: Jian Huang Li <ali@ddn.com>
---
  fs/fuse/dev_uring.c | 15 ++++++++++++++-
  1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 249b210becb1..eed0fc6c8b05 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -201,7 +201,20 @@ void fuse_uring_destruct(struct fuse_conn *fc)
  		WARN_ON(!list_empty(&queue->ent_avail_queue));
  		WARN_ON(!list_empty(&queue->ent_w_req_queue));
  		WARN_ON(!list_empty(&queue->ent_commit_queue));
-		WARN_ON(!list_empty(&queue->ent_in_userspace));
+
+		/*
+		 * ent_in_userspace might not be empty, because
+		 * FUSE_IO_URING_CMD_REGISTER is not accounted yet
+		 * in ring->queue_refs and fuse_uring_wait_stopped_queues()
+		 * then passes too early. fuse_uring_cancel() adds these
+		 * commands to queue->ent_in_userspace - they need
+		 * to be freed here
+		 */
+		list_for_each_entry_safe(ent, next, &queue->ent_in_userspace,
+					 list) {
+			list_del_init(&ent->list);
+			kfree(ent);
+		}

  		list_for_each_entry_safe(ent, next, &queue->ent_released,
  					 list) {
-- 
2.47.1

