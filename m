Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D8F6A8E71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 02:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCCBAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 20:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCCBAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:00:03 -0500
Received: from BN3PR00CU001-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11020026.outbound.protection.outlook.com [52.101.56.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F7241DA;
        Thu,  2 Mar 2023 17:00:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuvQ9CDuHTMoZoDb9rs1DRZD52BGA2lguPZ0TBoSd6InI4TRNTWQYv306bTWu8JaofJ9ALgDDCpx5MQV+F9V0R/aDN0T4sdhUxGJpwTq+Qy/6+fQ1pII3YOALF7R9JNwRQSl6cTCIG1mOzBevY4Dq5wXVy7WMN52ZFT5JKtsflH+AZXAS4u0Y0c+skSVPDuK5noB87ZonlrRe8Gx596LC/5bWOCJoeBEAsH70F2Yew+umsSwnIHQ4N1s1R0kaEHVBuKEz9HqjXa0bahlIZqw23dFMNMUvLM5cTNCj3uAtVf8yQqX8PkJKKT/OLKq1tJrYHRSgAqwVspHcaNOkKxqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcwaIoYuY8LkEKc/K8Y1d7YqRltWlySlqVn09ozurWo=;
 b=KTN6sLYr7jCChpiimVQRmeG2pwlp5F1YONzPfwqk82Bo5gP1hIN0ts/5vmbyLbbquIrmOlG+OAAmFY/CWH+jNmOzSYJE4fLLH6KpJIZb7HeqhrYmICTHqU9e1VIz/m1/mbD13u3Y1QknMA6ft0MJyeiU4vpb8xGjb0bC1CsMsUrRYDIgaDJdzpIuNA8f7IOcoQXb3vhAARofFUUYjUSmcEld+fYhxjQYxcRSBqHog/G4m3E/USZntIZ5gGJ1FM/LdpM3piFFMUfihHzYlZD1u+Ae8oaXt4OQ9JKCuB8Fez1VYUlxDabRUGJDItRZQUJhPDb77bi4tGv2VN2halZT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcwaIoYuY8LkEKc/K8Y1d7YqRltWlySlqVn09ozurWo=;
 b=LVLreJfQLFqKH8U4sGCDkzsfz9neFxkUuGRsl8DqLSj5AdVo39uRPljKiJo6tsjJFw2vbLB13JkI6SygMLOlOIOde47WEuuV3jRXazucmOfm3tvv7yeo/KrapIm8f9ro7ykPzvUr0gdOGV13GBqg3DqzAa+Hu/imBrVtt+xRz7w=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS0PR21MB3862.namprd21.prod.outlook.com (2603:10b6:8:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.7; Fri, 3 Mar
 2023 00:59:58 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%5]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 00:59:58 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "minyard@acm.org" <minyard@acm.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "song@kernel.org" <song@kernel.org>,
        "robinmholt@gmail.com" <robinmholt@gmail.com>,
        "steve.wahl@hpe.com" <steve.wahl@hpe.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC:     "j.granados@samsung.com" <j.granados@samsung.com>,
        "zhangpeng362@huawei.com" <zhangpeng362@huawei.com>,
        "tangmeng@uniontech.com" <tangmeng@uniontech.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "nixiaoming@huawei.com" <nixiaoming@huawei.com>,
        "sujiaxun@uniontech.com" <sujiaxun@uniontech.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/7] hv: simplify sysctl registration
Thread-Topic: [PATCH 3/7] hv: simplify sysctl registration
Thread-Index: AQHZTUghmT7Wxm+Iike4T3P5qQULMa7oPC4w
Date:   Fri, 3 Mar 2023 00:59:57 +0000
Message-ID: <BYAPR21MB16886A06B7D3DBC4A10EF984D7B39@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230302204612.782387-1-mcgrof@kernel.org>
 <20230302204612.782387-4-mcgrof@kernel.org>
In-Reply-To: <20230302204612.782387-4-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fe1c164e-92ed-4e67-a49a-a1d27905e5b8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-03T00:59:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS0PR21MB3862:EE_
x-ms-office365-filtering-correlation-id: 498f5fa7-384d-434b-9bdb-08db1b829bfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7luQdAIeYd5DgNZR0tGfR/9z4g/rMl+7zsncSixc5P0tSF2YznjxdKfNk2/XxD6P036DDuO+gCtuwUmxbimpR8Hpem3XHlv1oO+q1bTUM++rxQ2Ii0LEyz+wROLz/N31ouX7S+QTBuysw34y//aFm1YSLoWrjxlvUANhsy7vCei2qokx36c8iT9FDc0QOhdfkY6eZnUmehOfKTyLJFT/3kKh9dHiGM4pjos2Ycs+7PoXzYd4vBgmZjNbhCoixf8eO4mvM0aoPPiG8lkSITXpn7g3PeihGrs18A1AaYrr6JZ5DbZguaOTuJyt64npXPPPGaJyQJHLeAkEQoo8u0ixrNJ/3y2AR5pilPKj4vpAPUzlTXny3EYcWxg7dXnCTfuGsTA96I/uT92bCZv9TKH7PHLQSg/R5Rl+O/uTMULQ4u3rrVFgYD/EwNLTLMjNSy4vJZKcdSP2opAl0Gg8jgRMTXGs4vQ0KJiJ4PlMepgeg6UyUIgyBj8sEaNFBYuF3Y8zgyv2koCiTKmyeaVAt53oHJKOacAn/ovwnom5kyHaGxVEOEc3iv07s0V6i/fTN7s7TFZS7NzQV1L1tvprKry8SRyziTKBs0eb53aus1kwmqo4eIwwAV19RdCPtQDZTQy3BNuM58c+t/8DFDlvUQtQMkrToH27wp3tA9Dr7fgwgR9WZsyCqyuI0XCZ08XcToSrwxNaZJMRaUByugMqUm0yULNghWDvejHn2mTPf5aCueS/QolYN9ganhHiO9jg9rz2mmUVK5eu4VItO+bNagQV4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(7696005)(86362001)(6506007)(66446008)(316002)(64756008)(55016003)(4326008)(66556008)(66476007)(8676002)(921005)(54906003)(110136005)(83380400001)(2906002)(122000001)(33656002)(26005)(82960400001)(9686003)(186003)(7416002)(7406005)(82950400001)(76116006)(52536014)(66946007)(8936002)(38070700005)(5660300002)(38100700002)(71200400001)(478600001)(10290500003)(41300700001)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ajsq1TcVBn/ZLc3bc9sjhQmJ5VdDc49BQXeKLlNu5Xi4zQAjIAs7HTggdJef?=
 =?us-ascii?Q?d5lH3GhjyhYxRc39AEP4URGZq7GKgXxA0Vn4MfAje8V8ivdT+ZfFDUrCsW8e?=
 =?us-ascii?Q?7sSfq9xxnM5qq2U5oWNasrF8qnie2hbZ9LpmEyHusy2WOFiDLWD50Sv+Hva6?=
 =?us-ascii?Q?7bzMLasCQrRBrKzM0gqZP+5YiMjeIRb32uFOM2irqfBfj4cL/0imWLRD5Hq/?=
 =?us-ascii?Q?PE3A2tX/La/Kd+gdJHdQjFs6lHOjqVNANhP+Nf4GmBF3EphSt6mXbN0ou2OR?=
 =?us-ascii?Q?GN0bKnVDlbdI/H3V7D0Qrq7qhKlacE02BwZvPuDqZf3EPjJ3qGOIOL3PaTea?=
 =?us-ascii?Q?9CAI6za1+0JsolWIG9jauZtMVgB7taUYltoQ07FE5QD5Yoe7jLJlXV7/FrBf?=
 =?us-ascii?Q?B0qNP1LMdyYJ2Bm/HMHl1GniNGQyZeEja54IzlVTEbdZJtPKq4PW+LSod1n/?=
 =?us-ascii?Q?knyIGVPGr1AMLjwjl+iJ5VLtrMtyIUpvgIl99P0e9BnaV24LZhLdhxKxJObN?=
 =?us-ascii?Q?B2JFSUp2CDvw4j1aG9i2QSbrcWbDH/whvqtCspG4ader+UMxN78zbApssmDz?=
 =?us-ascii?Q?ZG7ebyOnon0A93z8ClnmaECKcl+VQ4LKYbQcYeP1Xx75vxArx5WZNvHwvK1B?=
 =?us-ascii?Q?2ucIk51ZHwGtB2AXNCQFUZJ2Hvk6hkOg4WQSni29h9mQinYPDkjl9JRoTQxH?=
 =?us-ascii?Q?bsnD10sd5jpQwKEhmZCVTBx9YxnP+jRSZw0qWanrhKjaskv+maKFjYWWqKM8?=
 =?us-ascii?Q?PkBWNrhxbuLQ6i2tAQUpUrYpfXvOA7vCQywuqiyDlLSzR1cxLNkQ6p69eIu6?=
 =?us-ascii?Q?L+sS1uH2rSjrmBTohd7P1VuG8yRUFAL6OIKGTjOxn2c69hkUajhOPHEYTSAi?=
 =?us-ascii?Q?I6AhrBAnCIAgCFUvvsqP1uJ+NYWUTCVh7Gw2cgIVvtHS608v4+Nq3DIzyJ9f?=
 =?us-ascii?Q?87oU27P4cZPjozZG+mNGMcVq9M87ha+n2HuHGDe0RT4e2z/alPMT11LjpFnd?=
 =?us-ascii?Q?rCL+i+0TFLZuvhZZodEYpL4SZq+13/lm4fwaJh5p+QUzd4MBdAJaeBgFXmnA?=
 =?us-ascii?Q?46/n8wKY4PeVwhJldIxHJaDUWERBY4Z/3bZzPu3GCgKfPc+rzxsDNxt2JqaX?=
 =?us-ascii?Q?xsSks+hYmF41SwWMsf9ztHnOFCaED+W9nbQmlLKOoF1ULbXQ3Ee1Ea/kiKTx?=
 =?us-ascii?Q?8woDr1xYwd2gTqZAPOzgJTAKNV62vXparryLddhI89Zg4SJG6zczb53yJLCK?=
 =?us-ascii?Q?lXCuuDSpxZTiNk32qLOshIDxnSq3K6NRONByvmZK/Fqqo2OP59MsPIWkm03n?=
 =?us-ascii?Q?etWje6b76FuXRvDJi3d0lEZddit+VzjvMQhN9+aVDzlTTcXG6P4FyoI/Erqa?=
 =?us-ascii?Q?fmywD0gRJZ3hCzj0VnIEcr2W7q0SxvBdus0yHywgex4Bwxt8Ck+uNvlEmPCf?=
 =?us-ascii?Q?h3l2DVTr8A7wwKI3o8mk8HKewLClpYeqn+UoCvfe9psUV3Jm8nfGAjWPMDMm?=
 =?us-ascii?Q?aUJmbyXPOiXE6GKni1hIF2P3q1GIaDJ2dI0vtmw+UatAnjSvGXOivH4M8MfZ?=
 =?us-ascii?Q?9MUBFg4n3Vtg7x+s7/ShI2o3Aq7UpkhH4aG6XPDeJQFbNvUphiZ1RzE/mv5l?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498f5fa7-384d-434b-9bdb-08db1b829bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 00:59:57.9023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcXel5WdWBH6prBf0eyu02o+jyHBBZnK9EZRtDBaMLWw1+SzlPHPmquDTa7XuodbaT1BylXcJcvDRudky5c3L+jqQLrpSx9i6f8CZkASXtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB3862
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@infradead.org> On Behalf Of Luis Chamberlain=
 Sent: Thursday, March 2, 2023 12:46 PM
>
> register_sysctl_table() is a deprecated compatibility wrapper.
> register_sysctl() can do the directory creation for you so just use
> that.
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/hv/vmbus_drv.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index d24dd65b33d4..229353f1e9c2 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1460,15 +1460,6 @@ static struct ctl_table hv_ctl_table[] =3D {
>  	{}
>  };
>=20
> -static struct ctl_table hv_root_table[] =3D {
> -	{
> -		.procname	=3D "kernel",
> -		.mode		=3D 0555,
> -		.child		=3D hv_ctl_table
> -	},
> -	{}
> -};
> -
>  /*
>   * vmbus_bus_init -Main vmbus driver initialization routine.
>   *
> @@ -1547,7 +1538,7 @@ static int vmbus_bus_init(void)
>  		 * message recording won't be available in isolated
>  		 * guests should the following registration fail.
>  		 */
> -		hv_ctl_table_hdr =3D register_sysctl_table(hv_root_table);
> +		hv_ctl_table_hdr =3D register_sysctl("kernel", hv_ctl_table);
>  		if (!hv_ctl_table_hdr)
>  			pr_err("Hyper-V: sysctl table register error");
>=20
> --
> 2.39.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
