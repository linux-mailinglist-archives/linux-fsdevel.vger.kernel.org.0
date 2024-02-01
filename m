Return-Path: <linux-fsdevel+bounces-9823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9087B8453D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472AC289E4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B57115B0E9;
	Thu,  1 Feb 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="TmKwcLit";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="TmKwcLit"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3A15B987;
	Thu,  1 Feb 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.45
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779480; cv=fail; b=pDn7fd6Wdi1A1+PbCSAgTmFlO6ZoLNh/uAqAkGbVxlcwhKIy5Foz4XnNaF8k4JFZk3ZfPv0p5VMkSlrD3wmc69RTX0zgoeab/7Tk4q1O57JvlPn6QpnR5xU2dSaBuv5eIsjR7/SpRoI5EvwUjVZhrcjxwbEt+pNmD+gDVTsFJrc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779480; c=relaxed/simple;
	bh=mhjm/D7VxhzYVu7NHol9oScaIRFEHcIEHbJAq/7uY0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q4FBtP5KaioeEywEvclaPjfPj3U9OZ3/Cbugq4I6dIZLzvAFLV6jXM3Aq51IVBGco3BTtfU8xI6HDQrfwqZp3M8ByQyFv4aDBx2ny9HYTHxuofOwBIEPUTwzivLdAl87r4HMWbE4ig7gAiNvK84MN3Fyvz9HUR+OvNJHjI0hqFU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=TmKwcLit; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=TmKwcLit; arc=fail smtp.client-ip=40.107.7.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=d4lJztiUWFzX59IsXaCmMckMdaQq1ib/dmQP8bB5yDo2cfGo2t5CMH0IOWOCw3m2QqrumF7IdAZE8/1rqrjZTKoewlm5UtZxOs/rx5zWETH+txgYrbNIj02zdU/NE5DYu8Tjtt8c8Rus8i+A6tVuZpIOvL+UR3/sCm9OjJSMTefJOmyOROdw/EVp+nNr9NBEtG9ziZxFj2AwrnHYZ0Uksc3brSvuDtPx4wnLu1wne+0MsbQf3syBsQhQDrsZ7IIxqaDdjL6RT5XhwfLwXYxTk94C6LJGeWwPMzlbt5qcDUC0v3JQVkUnqw03UZUi2IdwDtnwyIoMHClhGdZYij+CeA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhjm/D7VxhzYVu7NHol9oScaIRFEHcIEHbJAq/7uY0Q=;
 b=BggS7dPECzdn7if/lVNPFCi4vIe2cBPfU9IqKdg0Vc1+S0itDuRM2dMs/ENBqLepxTHRheK2FjB9YfvTLLJ1QDgfD27Tn6Mfi9t/tVqWN//zDokp9imA4xRu7gvG+4TE9Q+Tmexd/asEK8G+owSwJrLl9MUK/1XGwv2lbQaIWOftHO1DLiV9VBugDKJD7RcZAd5BL915bpbgio6PzJK7U+/VL4kA7rMSJlyyN7rabCFmtvVg05Y3Qo+jIqNhK+cvcpjIzEcGa1YBh0C+Gh6CAad8ceur7KIJPRscbP/07XNjag1KwOXpX5ii/2Y4eEBTnJP2td9tXgRyL+k6ZKk+jA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhjm/D7VxhzYVu7NHol9oScaIRFEHcIEHbJAq/7uY0Q=;
 b=TmKwcLitCAX3Pc1F1VtF6NGWzimWbCra4P6/Rtv9GqZWJo5E7uhJUukQgGmfvk8bVDNTM9iJwsc0MaI0W+/LJGluHfXW+J4YHraiaIQLQUpfgZb7BWMtxu97IJ9trt28IC5sKvvzRTnpDUaCw4V3TFNZ4RN7Sl1LXZrpJnmrLRM=
Received: from DUZPR01CA0352.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::15) by AS2PR08MB9224.eurprd08.prod.outlook.com
 (2603:10a6:20b:59c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 09:24:23 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::bb) by DUZPR01CA0352.outlook.office365.com
 (2603:10a6:10:4b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.27 via Frontend
 Transport; Thu, 1 Feb 2024 09:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 09:24:23 +0000
Received: ("Tessian outbound 94d82ba85b1d:v228"); Thu, 01 Feb 2024 09:24:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d54f52ae2c185364
X-CR-MTA-TID: 64aa7808
Received: from 6a9426d5ba69.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5064A2D2-874D-4A81-8DE4-AF401B038576.1;
	Thu, 01 Feb 2024 09:24:12 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6a9426d5ba69.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 01 Feb 2024 09:24:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfymZfFdSkV7wMEtKePhYfnopl/CPq2fBW/DSYDSJ44w2Rl694Yp+BGf3z52e7R8ppq2/67RrDY7EBnMjxpRUuolR61pKJjg2SWO42GOoT37IIolFng7XqL2+e/kPhuvvjKI7nfuxrQRs8Cce8jOjOm0lHd9tvr+gVp5H3Uyqexc7UVwgYwfmsVx+f+zr90rJyXBwX50yRfTUbX2FEOuhrINZu/x0iLUk8ty2Y5mAOtaIGA9HNV3cpVFWOrOjDyhwgzmaw7E83uL6jai5bUh6cKb+GtRrreZR3eHWmFEr0BCtQRG8pOzzG0wVfk/vo+RcBkZCl7AyDtVlH564UpPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhjm/D7VxhzYVu7NHol9oScaIRFEHcIEHbJAq/7uY0Q=;
 b=KMDKeDM7yRjBpc4zrmLzkGi5aR3fkuzhPsAhYMsEsxRw29e3aRnj2uh5XXfHIpzm4IhQunpNC9i6OI8i8InqJGioJ+U0xpg/eEAbrsdTiOz+vUCm5EwnKlNwH2esPnUFI478wFbmpW2RoAcii6fIQFXSwTKuY9jgwkDchcYZV20pV4zWduyq6V4kyg1odGNnNo/swMkBGmusfoXtjj7+WYqMn5hin/AgNDBO5nUzSBeWB2MFjqzR1hIvXZV69jHQwYYrccX4rO0c5yRWPYYlqrBYIyFuWvnTWL0TM99J+5pQkh+d9Vsm98gwL6nbxeGRuQf/d46b4oC3jyZBCzRxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhjm/D7VxhzYVu7NHol9oScaIRFEHcIEHbJAq/7uY0Q=;
 b=TmKwcLitCAX3Pc1F1VtF6NGWzimWbCra4P6/Rtv9GqZWJo5E7uhJUukQgGmfvk8bVDNTM9iJwsc0MaI0W+/LJGluHfXW+J4YHraiaIQLQUpfgZb7BWMtxu97IJ9trt28IC5sKvvzRTnpDUaCw4V3TFNZ4RN7Sl1LXZrpJnmrLRM=
Received: from VI1PR08MB3101.eurprd08.prod.outlook.com (2603:10a6:803:45::32)
 by AS8PR08MB8249.eurprd08.prod.outlook.com (2603:10a6:20b:53f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 09:24:09 +0000
Received: from VI1PR08MB3101.eurprd08.prod.outlook.com
 ([fe80::80b2:80ee:310c:2cb]) by VI1PR08MB3101.eurprd08.prod.outlook.com
 ([fe80::80b2:80ee:310c:2cb%5]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 09:24:09 +0000
From: Lukasz Okraszewski <Lukasz.Okraszewski@arm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Matthew
 Clarkson <Matthew.Clarkson@arm.com>, Brandon Jones <Brandon.Jones@arm.com>,
	nd <nd@arm.com>, overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [overlay] [fuse] Potential bug with large file support for FUSE
 based lowerdir
Thread-Topic: [overlay] [fuse] Potential bug with large file support for FUSE
 based lowerdir
Thread-Index: AQHaVGOz8JYJ8ZNYjU282lashynInbD0VE8AgADKtByAAAgkgIAADusp
Date: Thu, 1 Feb 2024 09:24:09 +0000
Message-ID:
 <VI1PR08MB3101AA24E1406DBCA133DC7782432@VI1PR08MB3101.eurprd08.prod.outlook.com>
References:
 <VI1PR08MB31011DF4722B9E720A251892827C2@VI1PR08MB3101.eurprd08.prod.outlook.com>
 <CAJfpegvBc+Md51ubYv9iDnST+Xps9P=g51NcWJONKy4fq=O8+Q@mail.gmail.com>
 <VI1PR08MB3101A133BDF889B35F14D28882432@VI1PR08MB3101.eurprd08.prod.outlook.com>
 <CAJfpegup8_Xm7rqbNgbxoZ0+5KnrJiiR05KLO3W4=mmQaRi+qg@mail.gmail.com>
In-Reply-To:
 <CAJfpegup8_Xm7rqbNgbxoZ0+5KnrJiiR05KLO3W4=mmQaRi+qg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	VI1PR08MB3101:EE_|AS8PR08MB8249:EE_|DB3PEPF0000885B:EE_|AS2PR08MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e9c088-f29c-49e1-431b-08dc23079426
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 Acsmeb8inrktIuzjO4T04cEXtBavbvcuiSCIYf4/X9Fso1RcYChFRxou1jMBRodb3zqNj0GhrB/xs8cgSuL9jdv3FHV91X7X30qUg8ZNWWJlOfE0FDFnAiyV3svPXbT+Ggjw84dIBxZEFRMBjVkRZ0O5P0sP8PK47Tfqaz7Imb4Wz9Y78PJAV8iRpRwV1F0c7ojgJFnDS4kahEgo3YhMyrp7B94JQ6FKTvvR1NG5D9TcoM0eSKkjy8WaSDozS7/AXhc4rJHYa0oWn/wBVea2DF9dUUjE2j4kqVKf7aqpUyR1GwTHmqdYk5F7pNK6gpU6s+MPHDynYnV9GT568b75pXDzxT5144oK8+6GHLYZ9sFb/HrfnL49Z25Jm81yGV6VNQA48CvunLdwU2oLn1DqjmWJA4Ibc/0UvHq6iM2g9Y82occ8Fl3nz3L9IT4MYF+1sczV4WbFDP9pflqfAPw/sygnAOCyKF4b8XVaLBW9jKI9ozVf5cTJ65PNqwXetfwRzwCICggxYbU3ZnlB4Cud5x6X8f/xxjMjR0mphoyQ4W4GfkhC+0WXcJL8JKnhi49zW7sRwfUI1Qw0C5Gc5gUI39fNm4oINYJ077RdjiXL7aWGtnMmAGZyplQI1hFjD8Zp
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3101.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(55016003)(83380400001)(6916009)(86362001)(33656002)(38070700009)(54906003)(38100700002)(26005)(122000001)(9686003)(41300700001)(316002)(52536014)(8936002)(91956017)(66446008)(4744005)(71200400001)(66476007)(66946007)(76116006)(7696005)(5660300002)(4326008)(64756008)(6506007)(478600001)(8676002)(2906002)(66556008);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8249
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3831efb1-c374-4f75-24a6-08dc23078b89
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fCFa2Rg/ueXAyP7NGvFPJGbJF9LiwZmYlMqWs1fOKl2j6gNU+SvNOZMgxl0wUN4qUIqkTb+48etstM/tgAVNUoBCop61I7nWJshO+2iH1wlQAA515R3advCsEywPaLTmel5qgsYvppLz0vM+fQ72O22dr7aWNQokV8ivpNUiir8nK+SYw/XGQn/1GfxJGQ1ZxgxFUCFaH2D4bai8M8kLB4k/b5YgaasFLriru3T0smfj5qaTOkv9gvtiY6dfVVyHXz6IQ5gRsDR+v32Na3O5SeFAY8ZRNPgCXrE/a2zuQQv7MAQbY/fE6JHPfz9mVzoDyvWWdgL7dGhzNpK2XKx1YS46W+DQYy6IHlDtl2RkX6bAwcj2F/7lpGVDeIDfyxWkutgTqbmnjYYI4lNiQZxTNPpSMNfjX9IVDCBi6N32njYBXIh8IqlJK2aSwxPmYy8BqCIm5U8bx+3AvCwPLsqRdjtPel0fvCS0pe5C8e9n4VNORAiwR+UfwcX6/mgvpT5v9lRVzcZY09MnQ0WAwngsA48OMkhRTArfHSWu4SMuPmDOjOFLSXasdfHZGQRbp8dbPldh4DItDXStBZsq5yfxAf5kZZq/UWpueEgTAHy3gBgG3QcNaMtN3ltg6uAQ/xteVJzWWVBjuYmFZ9/LZbUqf23I02uYTXJa833AsHOKylukbyicne9Ju5Ejnds9rGrtJd4sWNbY8q+S3Wb6zfcc7EifWD2nU1vu/zdS6MBTCItHUP6QcKbQ8FBJHOY1onAf
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(6506007)(7696005)(9686003)(336012)(4744005)(8676002)(26005)(8936002)(6862004)(450100002)(4326008)(2906002)(316002)(52536014)(5660300002)(33656002)(54906003)(86362001)(70586007)(70206006)(41300700001)(478600001)(47076005)(356005)(55016003)(83380400001)(82740400003)(40480700001)(36860700001)(81166007)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 09:24:23.6890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e9c088-f29c-49e1-431b-08dc23079426
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9224

=0A=
<miklos@szeredi.hu> wrote:=0A=
> On Thu, 1 Feb 2024 at 09:01, Lukasz Okraszewski=0A=
> <Lukasz.Okraszewski@arm.com> wrote:=0A=
> >=0A=
> > > So this is a FUSE_IOCTL/FS_IOC_GETFLAGS request for which the server=
=0A=
> > > replies with EOVERFLOW.=A0 This looks like a server issue, but it wou=
ld=0A=
> > > be good to see the logs and/or strace related to this particular=0A=
> > > request.=0A=
> > >=0A=
> > > Thanks,=0A=
> > > Miklos=0A=
> >=0A=
> > Thanks for having a look!=0A=
> >=0A=
> > I have attached the logs. I am running two lower dirs but I don't think=
 it should matter.=0A=
> > For clarify the steps were:=0A=
> =0A=
> What kernel are you running?=0A=
> =0A=
> uname -r=0A=
=0A=
On this current machine it's pretty old: 5.15.0-89-generic (Ubuntu Jammy). =
=0A=
We have seen this on Arch with 6.6.12-1-lts, if you give me some time I can=
 set up the repro on that again and get the logs if that's helpful.=0A=
=0A=
Kind regards,=0A=
Lukasz=

