Return-Path: <linux-fsdevel+bounces-16245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0291389A82F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 03:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271A81C22AE3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 01:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672617BB9;
	Sat,  6 Apr 2024 01:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WmoEHDEr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kkmyAnqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62FEFBEE;
	Sat,  6 Apr 2024 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366203; cv=fail; b=kfiRwb8Ms9ZarFgIQhmCdzYM8CLOs71WCSeECwwITnF+oNWfNW+goq0D6cUHep0nJf4Xo1oAtbUEZxsX9bBj/lTjAm2IbAE+VpumA9hiH861y9RvJ0/cVY0G20nNBJa539EhrGsr1suARSUmcpzOBG2+W13bvBbojwMu3TjMqaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366203; c=relaxed/simple;
	bh=5x+zUh/gigPwU77qrJdoLgtub/FslB/KDFaot4xzF7A=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=dsHoECH2SjPKc7MegpQnhsfV7GF81XGFWxrczlvSc6csaz7j91VfacZpV/p0cidB0anjnFrBbHsNL3GAadePH++e6he0spIRveRQa1vpUVZNvQ7fgs3vMy2TJymnMm+S6Tzx3S6HdC78HDv4blGaufeE8Xdwtmu3D3SDxF2TEy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WmoEHDEr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kkmyAnqJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4360iJHE016377;
	Sat, 6 Apr 2024 01:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=V46fxPXPKkIuq+fDVPYM5K6s+NTMlm1XiN3ewDC58bw=;
 b=WmoEHDErfwUXeszF70MDZ8yVIQh1xhCuEZoaGRDLIQLK3QdrGFbIhKRTq57gvkWWRZK+
 SX6unj3iWv/MiMok7sKMwPgSEAaBl0AB7QVwgDcOpzSfh6NmCohZUb9lNlgvErahGA6P
 gWSsnTVxG8ulynafAqVa+MNZxd2XtAP1rw4PPRX203KSG4hmGOPBjvC8vIgHIBIUC5A1
 +ojnItwSw+PKmf6uWVCZplGYTJlmTX3q4HNMJoAJUZkAXmCoiw7DjRpdSUrH7zPbz+me
 bKUDPBz03Fgv1fYSo5w4oQ5ZG6Larbw0LmqbILmnKCJFezE+MLmQadc3jD749HERxOzQ WA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9emvvnas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 01:15:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435MHfc2030595;
	Sat, 6 Apr 2024 01:15:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emys2gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 01:15:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1otC6Q4EdjdFFXVM+mcmVfRB+I+BXz1XBvtzwVrLoRc+GH1YeJ+JP8WlUmeEtGZas9PU6MSoCYRwgK3M2IbExLD9NH8RZSUbXAXaS4CWxW5TyfedwESwsT5YjxDzZg8wtIr990ONUAbE/9DxwO8AC5uv0vWKWvZfxKCOyxAdjbsIrciElZzSimmQO9+NoFLQ0ugyjZ81kdlbJJYLiC7tw/ztHH6yonbbqKuQRDiD8DNTFcNUqwXx2bhQx5UruyCOPSs7RwiBh0N3cbTnA/wi673ZD9YeE+a3bxt1MNQjamCK6sqMTtdfFBbKpiru594KrBIr+OQmAjKXrbTkWD5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V46fxPXPKkIuq+fDVPYM5K6s+NTMlm1XiN3ewDC58bw=;
 b=HNssJvP25alxa/LhqX1auIleR00yA0MWRTkL9yeOrS6Kj+VHk9DEbY7PX1/Vn4C2h8B23aL2x95zSffxZcVLl4azgE0Ho9yh8MuphG1xkXyvZ/RI1Mj1PatBiAr7SR0ruV8+CKvodv5GVViIslHCvw2sHVAufjgpqer/b7/gOUFBsurINrsZxrYqJWcyICefFej4lBbTRs3C1EyBnohrWPcZikViB/PWFg8tMVQ+C5w84aWoOJ0Sl+yA0/8//PZJwMCNloBPkUkkeDXrdFiIf5FKZ2YZ6uGggT5KrtOAlaJD7Jxq9dBpKV5xJ/f9Y4hIyOIH1cc8PBPHSOgN3UgwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V46fxPXPKkIuq+fDVPYM5K6s+NTMlm1XiN3ewDC58bw=;
 b=kkmyAnqJ2ccLLOg1FrfbNRMQlOxTxdywstKfQGtPZw8VprEzjTk7VQ7DmYcjxoN+hI1e/dMapRBjX294GBzI6YkHnhNPmTicHNHwdk81Uupz60V9JePEcSckeQEhK97LCFAmNPvDiFr/vDglnYQtriMa7Bgbu8jccL/ay++4O8M=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CYXPR10MB7973.namprd10.prod.outlook.com (2603:10b6:930:dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 01:15:50 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 01:15:49 +0000
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jonathan
 Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        Gerd
 Hoffmann <kraxel@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Anton
 Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan
 Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Marcel
 Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu
 <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>,
        Arnd
 Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Gonglei <arei.gonglei@huawei.com>,
        "David
 S. Miller" <davem@davemloft.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar
 <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz
 Golaszewski <brgl@bgdev.pl>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu
 <olvaffe@gmail.com>,
        Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter
 <daniel@ffwll.ch>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin
 Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet
 <asmadeus@codewreck.org>,
        Christian Schoenebeck
 <linux_oss@crudebyte.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Kalle Valo <kvalo@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang
 <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Pankaj Gupta
 <pankaj.gupta.linux@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        virtualization@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev,
        kvm@vger.kernel.org, linux-wireless@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 23/25] scsi: virtio: drop owner assignment
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240331-module-owner-virtio-v2-23-98f04bfaf46a@linaro.org>
	(Krzysztof Kozlowski's message of "Sun, 31 Mar 2024 10:44:10 +0200")
Organization: Oracle Corporation
Message-ID: <yq1ttkfqolf.fsf@ca-mkp.ca.oracle.com>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
	<20240331-module-owner-virtio-v2-23-98f04bfaf46a@linaro.org>
Date: Fri, 05 Apr 2024 21:15:47 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH7P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CYXPR10MB7973:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2+RvhkbvzGKL+l9+r1wutWaaziZNpCMThfCHIkOj7NLnMqIhEsuhFQ7ePy60RZcX4lETV4k7XtOGxcnsM3MUWnaGQtDyuOh3WouU1Oj70uEdE7145Z1sPej8zn9X97iRmNixq6fXOC5RH28Sv0RdIidlxFoLle6jJ3+Cl9XiYl4y8wzhZoR5g8+/TFCz8LQ13L2MqPUqmt35ljCyFG9jUIMPlePIEmaCbAIJ7am61nggpDPmMD/JZkvodvkUGjd3t9BIIkaE7LzpASI2zYtSi4CH2Wf40/pD7h0X8l+AaG/eYssF3GBUXo/L/kTraK9Qr+719Vin5DitTIOW4j2PLIHTaRPuU8B9Xt9F3JlYA3TXb7PeyzRPCCum4fV779gd5MXsfA5dRKsEconHlKHCu+A+brLsSVjVWBO+wpEzTKuZv14WWVLzQarEKAF1W1otBlAmtQEgyg2l//F9tfWbo58uNkBpPG6JQd5Tt0rsmEWBzNPi3yX1009VzDZnPGPePk1wN9X8ri41fp/wLD00ukThRFVDeeSwS214Z4KOVhkCjlYudB2OWEfFjebeGQgHBnLMCA6uycb6YVlAeE8E+edcidNlL7PN0XK3misHjpxKQ0P8b+jkHIHRR0+7tscuMZSZaFRj5X9uA9zJDnQAO2+/BhBQW63cVN09c0c++Pg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fCzv4Ruty7AsumpLqEfBYa0w7qG8LIsX9xNzvJMazVMgyeSi9oHlvV55v4+l?=
 =?us-ascii?Q?KEOblFrKlvIErgOa/ELnOLvLYBYCj1rNIuRIiv8LgYGGZNLeyUyfJh948HxM?=
 =?us-ascii?Q?JZV6aucUlFLn4TDg7yq+IibBWUevEvTl9tumJuduDHtmsTyqxbPnBODkkh3s?=
 =?us-ascii?Q?6S9IX2S3/+Van2ToEtV87UlagcDi9YFmbXbx21ZME7B/LCHRkNCeiW6ZfTZx?=
 =?us-ascii?Q?T9SRhq8QZZvz26qNuA3Gma+4w6RdvNqIbcrHZ1Fhpw5Flyke+ywddG5mv2VF?=
 =?us-ascii?Q?wOmAxMNHUBhXWRvlFe8P7d51CwbADXm8YHTnq4IGGajy7lTr58zqAwpzmQ0o?=
 =?us-ascii?Q?PyUQKae9NoWhSAvg/RkFsxL63OVLYhWCGxzPuSvQcmue1Bkg3JpLJTovwNDc?=
 =?us-ascii?Q?clKb2xOpm2xn5irBBgUxHNotGX9ne2HscMm1YjkKaYYoVxICr8g+ehdwgE2X?=
 =?us-ascii?Q?znBkm4/bDLF6Ox+stEWF//2kGo5vicCq4YkkIzWQMtIyQoCixPZeNRgB3JRU?=
 =?us-ascii?Q?XGLLSD/Z35k+ctrEyG0TYjuHyHQ5VRXbleW7zhfkpE8L6hpGu9MuH0yr3Srw?=
 =?us-ascii?Q?kipM90jr5hby6TnUUqr3Eueas7Q7pj1mZzYslkdJmHGx/T5yjpHs0rthNP9U?=
 =?us-ascii?Q?aWcS/frgK/BRj8TkCfgNDin8PQFbVbn8eyggZlBDGMspSFJ5u6+8oPJQVfcH?=
 =?us-ascii?Q?1CKXgwZGJOTMc+fFM1wGqrMwcr0a+1G7TBjO5aX2vQzlyyIeiDxADIeCxnrZ?=
 =?us-ascii?Q?7nI6zNHGTBmrHio6K5lF2WLtRbsoNbQ6nK7XjzRJ5IIIoWEpNjlnN0WUGIKS?=
 =?us-ascii?Q?B/3e4zov/Q5Z29b6Tsnkex1PytgbnGuCrEaQHs/xnB8xvfJKLWAvE9HV27dY?=
 =?us-ascii?Q?Z/g1Ekzsa3ZBda3ErZXN7TQONTbA5zPDHx6HudFKQlIERGwUPEmUJHjCGW0h?=
 =?us-ascii?Q?yPAV93Es2MMgMx9d0egELO21FKAfsnBFYrthwATAR4awJ8eyLoaORS/OwKYQ?=
 =?us-ascii?Q?OwlCEbXRtFhnZNyfpKHNyVNzV6iOCwED05P+NW+EUs+t0XQXcdraEy3QYSna?=
 =?us-ascii?Q?baJ5CooZfRxN/HKgohxAK0DcqPbi4KYte+/gpEp4LlGaa5ChxXkrBwV44hzo?=
 =?us-ascii?Q?fBUutNyansr08fw5UUmpDAxjoIeVEv5uFrKUBg4LCF18p2hJQWqzCFVTxZ3s?=
 =?us-ascii?Q?b+iyt1W7E9Hjr5Vk9mm/aXeUErCkf5kT55DXezR0AvjDH2BnX3kSB1YOLY/T?=
 =?us-ascii?Q?enZKk0/y5JdYSU3wE9kY7VeDdTdVsgedVhHDVaSbf115ZaneUdIoVuucjCM8?=
 =?us-ascii?Q?F4ANPRbe2wo0etgplvICZrsT6Q3kjWV6u1r+yPPWMQeZCUyxNcvW7G4OglGH?=
 =?us-ascii?Q?MBezj45hjwmWafjpPCQOOjXtE7kkhfY/FGAP/4twx2yXPMumF6MNZD1rska0?=
 =?us-ascii?Q?GwoSqirH6iNP3+4icqs2MbfNIPL7E1McELEGfNDfeYrg3oU5ccZVwnoTFB94?=
 =?us-ascii?Q?40QhjO670wF2PTAqq1NvSSA2h96NQUCdGl4BD1k+iJMkdOp7S6l0f2H16524?=
 =?us-ascii?Q?jIvasKCaaFgXv3O0S6ZfrmBLuf1fWgwTEZh6HF2ThpA/MVGitda7N/El6TdN?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WldqGYUH6gJp6FEaUu0cEC0TbSPaizmKuyyVjJXfFlwL04Zsjnh0aBfF4fDB6v/z29AQ6+XIxmFglidDEo2W1YrslRf3T9g1YYdOqTLf1oaqgIrLxC6XqUWlnliNuszGKA+2hJfchjR0FSLLOiRmpVRgIpyDxcKUfgtcWAalm0j9tYLjAdVfalJDYb9ACZQq3lS+2ZAPMfRL6qv2OpUUMYMagZeeKO7VFHeWZNvUuLg4XfYzXfC9CNM1y4lFjag+PcEuxw4TQUeDnJm9l4OC/ZNiju0xE28Bwt19+B2FQdxeAL464AOWi2Hw6BRBSDLsj3Y2hwtp8hKkOHZvBuO7NqwA2GQ4MHw2l3TolvFkbsoUfrWwa9VDX8QHO3dituwgwNQSaUGbWulYy6QTbqE8AEx5Ha7SJC76dIjyR6qijSUZ3NI+20LbpDjpyCx0lxs1pJh4UOsATX8Gq2nKiVqzDdNOvSpjMMr9BYwvCQl3VRxWHl3c/92nw/N5STGMs8vgimQ7Bw+r+jgv7ta9JAqCsqHwNYlZSNx/dvpL1/yfcS1eaBdFJ2TDG/DU9TFVHO/gm/ke1E9MglZ74oyStWUZALEBKaV06SKSWxRyzJyRbx8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c66396-928e-4122-24fc-08dc55d71871
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 01:15:49.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwUZDmZYyxSxD8sbWopBPEvJ518bmsqIucjBdWHXAbzFRe7xsHCfRp0NZkPp2MNtqUjNqhdwCubKewUJ7o4lSTO/AKhxGlon1MOPY7FW1wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_31,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404060007
X-Proofpoint-GUID: hVds4OPjqfLHoO491QkmqqJUZ-Ij3hev
X-Proofpoint-ORIG-GUID: hVds4OPjqfLHoO491QkmqqJUZ-Ij3hev


Krzysztof,

> virtio core already sets the .owner, so driver does not need to.

virtio_scsi looks OK to me.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

