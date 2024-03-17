Return-Path: <linux-fsdevel+bounces-14569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3352B87DDA9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 15:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C091C20975
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DA41C6B2;
	Sun, 17 Mar 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WolQ3EI0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h+xbiSMM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588F1BF37;
	Sun, 17 Mar 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710687486; cv=fail; b=QTaEBlJSplLgR+Kb1dBR1amqqYzo9pLm64F8yJnZZkFyPUwEYyp3iMC3hOzrM+cmgaHKHqx+H9waNhIGkELtSfXdeOrOOe/nanwi2CYBsWZ5n5JrbaXi3wqb882ORlWePDbodRwgqelx66gQN/B/uQ0QzbNAqkpcap7SGJ9nCM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710687486; c=relaxed/simple;
	bh=XJasuZpI0zWQWXP0mIReGPXdKFRo0QuLd9pwFpq+Khg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQXfbj7MrXuDEXrxh5u/noW3MY0Ve2FukMRDBJYtcKnzmCOFRKQEWvLMchkHhf4kRg5xvOTWipLxXFfEhCjDjxx50QkVjQv2LHXCXe2tAPKB5gNKek2YEGO8NiTGY0LqbgXnxTmKbe1zmDF+yl6NUpR5WtvZeL3gmf+Wdd2dVAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WolQ3EI0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h+xbiSMM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42HDTqTH013915;
	Sun, 17 Mar 2024 14:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=DfHCxOuMLZEWrQYeJGBzBeWhCnOkq/YXsGR5UuS5KcM=;
 b=WolQ3EI0Q57uTeJsj9npAwuKHf20TZdDKC3LAvYhDPW0Y+RUxTDtu0Zey8VpCr4XLMzJ
 Zce4bvMnzGmCO1oZDR439yHG67uqzJY2b8MyRj0dk0q2gz8dpGH1UkIu0QmaAH/gZfZl
 JSuQa0Jhmlgxboh+NzJgtAEzDPmLDzV2bJJIOPLVlJWn4MueORxqDe41hg1hFw73Bvlt
 HZWNbMVP8euhsuyFUBMYeFw0D+Sy15py8bhXpwgETtxgoiQUFhIGRHBbGQc4r6DgAxNU
 aRNJj8aeY3q6fLtyusoB8/rEYWkTGatPx2lV3lOGdXHL5+2E4380Rjul8doWcEAKjM4a oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3yu1e04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Mar 2024 14:56:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42HDa9sY015756;
	Sun, 17 Mar 2024 14:56:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v49mwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Mar 2024 14:56:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+aCq3sGfsU3iLmbWlFYGn2x0OtiYO+W8spDhrGOC+8XKe0nZ1eMvTjiGt5lax38yf0CcURYr6nrB9od3HtrnSmn50O0BiHnUtGuR7NjVLEzKqKWFaCIl3NPGnds8uz4N2N9FXgbxA5oGSKky66s9S4A6O3MY5cbd/LECpdBW6cnzRxzSv8EAPFESFNu8w6ZTwzrjmbi3vsSxcZMH1G3Zz4qrAHZA0jZ5V69bX3ihPidIU1F09LXiP4Wfpwy0DrHECugwO9YYL9KPGME11J5S1FB07ZnzHRS3EdeqBqpeBSUxer0wapEQdg+dl4Gb567xqpkGKHwAgctSwevbVrugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfHCxOuMLZEWrQYeJGBzBeWhCnOkq/YXsGR5UuS5KcM=;
 b=iSUEn1Ge6aewT34qoRPvDxHenpOQeLKsIo7ggdbSPbFXW45IseXIcoWP0QyoBH5nC4Pu8jRgpGtkDhc33bzoQv4hRDyAgl8+dcniKzyWmB207/Y/8pgho8m/DT7w/jIPNeaSwCnmBH+KawrvCwAz9IWOdF8Ti8a4NqLecwuAfNuScJZKenneNgx36l2NV9SinbyhGzxVc0hUKUcbznMSp42CMsveeY0FuksP27Q82QIPVB58Mgh4pIdhUZV7LvuYM4yUqnDyHhccEpfpwh4xdwRCIlObIqabWkR5dDrJRDINOyw0CrHKEWVpQDdx+k7kCJHaPFU7ltvaJxUH45Tq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfHCxOuMLZEWrQYeJGBzBeWhCnOkq/YXsGR5UuS5KcM=;
 b=h+xbiSMMaI8Fa1zd2FSfyrIa/UBcxIaHRd7RlQ8FbqIC18BcFf1IJdj2mp2nCF4I/32BCyfGGbVVRPRhQvvTtXZjxreM8C30rrU6woS3sNOI7HVlkXvgEG78jMF0ql51IvrsknAeeBB8jX16Ih1VsvOUqHCkMX36aWcOJM7Hdxs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4693.namprd10.prod.outlook.com (2603:10b6:510:3c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Sun, 17 Mar
 2024 14:56:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7386.025; Sun, 17 Mar 2024
 14:56:47 +0000
Date: Sun, 17 Mar 2024 10:56:37 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Alexander Aring <alex.aring@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
        linux-unionfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 02/24] filelock: add a lm_set_conflict lease_manager
 callback
Message-ID: <ZfcDHPq68nZBaY5D@manet.1015granger.net>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
 <20240315-dir-deleg-v1-2-a1d6209a3654@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315-dir-deleg-v1-2-a1d6209a3654@kernel.org>
X-ClientProxiedBy: CH0PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:610:74::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4693:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba56375-f60c-4c9a-4a1f-08dc469277ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oDs/L4awYewwrUXdkvTm/LQRt8KSHx3DYIOnvAzTaATbgFcR2+RNfAh+09yGqtA4+p6vBfVbtmq+W1okMJoSuwWhtMWmEPz6dZWoAYxqP//9wT+NfleQybkykYDWoTDgBOIrgGvguFPQxKakJ2rsqhmPgUPM9ptMC5deakKkPqqmTTeJbN0b8eDvmpSRvIOkZZ6l/IFprjEJTN6zL/rv1db1XsUED6dKMyGGyLEw5A7w//Q0gVXqv2iv5WUX/6tE+OEEoHfkDGFSPrtvLx/WlDY5X1pp9w11YuV99oeMCIeLtNE1YiFC/5sH2YlIRMTa55R5kJIuSXi59dorIDj0NyiHEl0eyi/fNHHx6Ba9ueV/p+UL9/qDaehNPiaCz8L0v6XMqkpdgfbyJ4qHfiqEoi/RaYwRpq5MaW7ZdYo3jGcXOT+t0qojwEOzUtOI0yW/ZN4v0fjk0g/7kPS3KsDidhct0Rb62m4QMsjxoj488Q6pRPD4YQBQHHIozZ6+SJ8CP95RmuDkEcMrmkwaku2mlVXCXyvvY8TvCi8JeGs50UQNCHmVjGdZu3JxBBxaJwWr4I5X5rXlaY3PN061AQuhb8l9iuH95MedDrbWNDq8MJ2yoVK6RdqTno9osBJtk6L3PFl3SFWB97SU7+GowYf7VZ/1jY2x0h9D9LSnYGBtYig=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?up/3yb9q7Dss3wTossytneGhVRlNGrkwXVCD1Gh5GEiqp1Bcd2+f5+Y/gJ3g?=
 =?us-ascii?Q?51a4Had090X2d5BfJsdots6XrUvqPkVjng+MFFduqDZGB5bvE4Xi44rIhC3w?=
 =?us-ascii?Q?ZwzR4l4mm3GPT6ZtGfjnVEVmh+19+g5rRnIFnCfsEoy8JOgebGOwwsgWwxyl?=
 =?us-ascii?Q?jOePX9Sq07CE8YO1+dgtYIk+drz02hZVDAU0HDjw6KYJsvkFTI0JCOBmKnEl?=
 =?us-ascii?Q?4824RSYquJNMmXui8xRVTUp2HELEIK5vLAg9MkqYDRzKBoMs0SUJJpU4zv3J?=
 =?us-ascii?Q?T6jhRhnTDFsdNEYm3JSX3mrJDzVpGzDdSw2Hxljcfla0P8vgD6jDiXXqYC0c?=
 =?us-ascii?Q?PTxwx6ytwxVTCq7sgHht3PbGi2mZPoK5o9EcDIx2+TkqvhcATPN2P0sl8Fio?=
 =?us-ascii?Q?0y0WZEjq6UhufGNOUTTEdzkry2K1B0gySy7eW9MKo0SfMgKDk5lCWmwXob97?=
 =?us-ascii?Q?u77c9NPp4ATRATuWKx+iKwG4s4jqCVoYyUpaTcnei4Dj4JsiD0kiOimN6wSB?=
 =?us-ascii?Q?PJ6xKe6cfU0u4H/cOFTxyG3bVcAnvoDNiNLuVTLJYd5IL+mkbKc3g4/ajwN0?=
 =?us-ascii?Q?vHhAam2PiBcBdKipAx2YPbUyJ80J0dYzcqpnDPe2keBAmRTJUL3P14Y/ordC?=
 =?us-ascii?Q?ago3vVLrvz3wCt1SpFFhmMayoJdzshbEuFEfNR9Rz0GK+uxQwpWaIri6LVIL?=
 =?us-ascii?Q?GEIk1/9miZ/OTUWD+j1f7tuLQwgwg94iz+fiiI3oT7Hl4NvPS3B+BOnq6hmG?=
 =?us-ascii?Q?pp20mbQe4IM+8erd2soxzimi2LXj22Izujbhhzhokc+4kvUGnsiIzdAmGStH?=
 =?us-ascii?Q?5i3mANZzN/lYycRyo8GTdTuLV64bBme1y4XPueVeZWSsAwDbaHcrZFLQHq/5?=
 =?us-ascii?Q?Oang1BKydIjQS58C7DJL4Ud5GXSdVFf6oY6vtFN66i0LgelAy9yx/QQhMPUD?=
 =?us-ascii?Q?1IDQNUF7Y3WMZL6H5SFF6tZ4+caM3XluwiQPCvSY8sLjbHrme/JYNcF8gxs7?=
 =?us-ascii?Q?qLAkv0YbdGM0j66ZMnAUh94EmNAizOrKLw9RD0eF+apnAnqEMhETDaxoWhI+?=
 =?us-ascii?Q?StMaSUIzzHGEB0XiuMhYh9n19OTicjrd0iAq4zaZgc8xPnS4z+GutRuaRujN?=
 =?us-ascii?Q?GS87E1OtyXCsK0saISQMIV0xhdmzK8BL5opc9M4fZ1qFbm0l9TcpRRsgw4MA?=
 =?us-ascii?Q?axdNH5PFELdjgWjYoazbnaxYKEuHycMzOzWoKpp2G/GX8LPyvxwoFZTCqzJO?=
 =?us-ascii?Q?iRJczNtD12GL4V04bpVogQux6LMbNv4kfdtmzguMH1JUvdkmBgFyopQ/JJZT?=
 =?us-ascii?Q?49i9/zcNrZgnyRnsLgXAQfp327SNB4pPTYNuhO5XSDTMap579OeFjz98jEFv?=
 =?us-ascii?Q?9HyHtY6X7UTh4nKVRmg3TXpEfcQwvu6myJ3zGjZoo+dSwhwdd4IvTVrSFBua?=
 =?us-ascii?Q?pRRKNdksqbWeN5Yfxbbk+ZcCkF4LWlxdGiNdlVKdZf1TVeQ77qYyGzw6JhkO?=
 =?us-ascii?Q?9ZS/LLpa2jTg9XeliAgwKta6sWXe9T2oOORHfNmv4W6JhijfwBlykyfTUSiK?=
 =?us-ascii?Q?9w5adv9sUwJ5L14A8SVJXRmi6ZJ6p8ZAbmNc5ZRe+hThgQoTw0noKdcXQLLw?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ucWCUXp11/HnCWtCsaNOD4LUKMXvnzWMUztY0NLuGUH3ICq4SBSWmSgwFe6Nw5Jt0RLGy1A24444OHwO+3egK5ZE/XJdZVjqLLujH3n9+E82+xVYCetWov9Zo6yFMNA2LdOjgv52Qu0fv0px2bmcA9r8KbQQBiIjhq9lGC2pyRyuP3VnJSRvrR7pko1D8xIR+Q3zf19AVnubJOjjsPVsSU9x3WXfEkspVZ1xseLLpWrTpVaf5A8ROCs7B1IfSNH4/w0TjW0fq7Kr/OrOGSU8dkCODy88mDnLbAVRCtm58dAM7vPTTdTUtKu6aCAVqpQmKQsFKX28REIDQ759ce9m81x5jBZg1IWX76ouyEWg0hef4B9MuOYymbiC39ZhW0EpP2xkvBn8JpSW+UOtQVwTiPHXKa8MTC2mdfmVdtpn/xjzQvbqjzPdwKBBs2hF7Y4PfWqSIscFkaIQGDqtAsrjX/44AsGzIOPoEfpRa9jpodjSd1N+f+M/VtPdVtMt5n6g3LgPFhZJoUyrC3OszoL1HJwvG3p7kVWT5IC+7ubGxP7YYsfS7N0lqmna2rbZiJViZvrwcWCEhhm9DZdeAHfakiqQpszO/E57aDJ/JHx+8bk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba56375-f60c-4c9a-4a1f-08dc469277ed
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2024 14:56:47.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZmAkwH5CP83TJlAFEajxWvg9ra74XwjSZYZKGi0+PE4Tjx5r1Vmq91QwwcD9zntU5Z4Gn2i3UN/zUCvDDkpfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_10,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403170117
X-Proofpoint-GUID: jqTna1Jy16LDnR5-c6p6l7ATj0QxRhXJ
X-Proofpoint-ORIG-GUID: jqTna1Jy16LDnR5-c6p6l7ATj0QxRhXJ

On Fri, Mar 15, 2024 at 12:52:53PM -0400, Jeff Layton wrote:
> The NFSv4.1 protocol adds support for directory delegations, but it
> specifies that if you already have a delegation and try to request a new
> one on the same filehandle, the server must reply that the delegation is
> unavailable.
> 
> Add a new lease_manager callback to allow the lease manager (nfsd in
> this case) to impose extra checks when performing a setlease.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/locks.c               |  5 +++++
>  include/linux/filelock.h | 10 ++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index cb4b35d26162..415cca8e9565 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1822,6 +1822,11 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
>  			continue;
>  		}
>  
> +		/* Allow the lease manager to veto the setlease */
> +		if (lease->fl_lmops->lm_set_conflict &&
> +		    lease->fl_lmops->lm_set_conflict(lease, fl))
> +			goto out;
> +
>  		/*
>  		 * No exclusive leases if someone else has a lease on
>  		 * this file:
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index daee999d05f3..c5fc768087df 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -49,6 +49,16 @@ struct lease_manager_operations {
>  	int (*lm_change)(struct file_lease *, int, struct list_head *);
>  	void (*lm_setup)(struct file_lease *, void **);
>  	bool (*lm_breaker_owns_lease)(struct file_lease *);
> +
> +	/**
> +	 * lm_set_conflict - extra conditions for setlease
> +	 * @new: new file_lease being set
> +	 * @old: old (extant) file_lease
> +	 *
> +	 * This allows the lease manager to add extra conditions when
> +	 * setting a lease.

To make it clear which return value causes add_lease() to abort, I'd
rather see API contract-style descriptions of the meaning of the
return values instead of this design note. Something like:

 * Return values:
 *   %true: @new and @old conflict
 *   %false: No conflict detected


> +	 */
> +	bool (*lm_set_conflict)(struct file_lease *new, struct file_lease *old);
>  };
>  
>  struct lock_manager {
> 
> -- 
> 2.44.0
> 

-- 
Chuck Lever

