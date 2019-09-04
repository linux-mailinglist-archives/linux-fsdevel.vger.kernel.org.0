Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E9FA783A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 03:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfIDBxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 21:53:07 -0400
Received: from mail-eopbgr1410137.outbound.protection.outlook.com ([40.107.141.137]:16910
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbfIDBxG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 21:53:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zey7bZpPF3UheO98b+vAxYFGu6HtgjdzaHR5j7uL875orsSTxin/UvZWnX6e0SaQ2gGV6jTkkARPg0jZgsWU0qwwOtxWChxJ7Ot5JnZCkmhJYPbUmX+Fm9BRYdg0vV4nCNtsmwO2T5SLl2d9vF02b2Zn3OztRFx4HQf9d1OuyQaplj9kCIo87/UGV04H7XVigLTPU7GElT6sR5ZjI1ztFzgw1CwNMQBcYO0nz0ex/WsBylxb5ag6wZFKO717cTWfiN7E+kvg1FTWn1bG4cywD92okd1xjLi7KTN2bhbiVRYvqyu2WBoXPrVbrIMI4G0Lf+XzH60NtdrkbZl8IhkrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuKBieB+g1++pW4pKO9wNGvSZ4A91H7c7FnFMzErAVY=;
 b=FSKtHVQXYY7Mv07vAmTtHRcDV9EqCf7zCG8Th71NlIylN2Gb2S8UaJYTulNU6DRBzRdXxzXVuu3esIwQt9ogqWTe8xdfsE9IVYHpk3etNZFAuiY0SGBuSX2peC6sF+4DwTtwdwe+oTXWgkWuVDlC8l2Bxp5SdJBGNqM+HYSc/LGM86E5HOWZm9CreN8ccmNlL/6gCLWhl7K3CiHJbU+ZRam68CPX+SVbES/yTSU2wuCJrTEjLW1g6o0ySW2wGwltpDB9/1dQIZcwsavT23SlpBT90q4D3ns5dQZ8cr4UiziW6JQlW8DYiDlBZc08xiT4htLgIG7LYu5Vop4t1ZMs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuKBieB+g1++pW4pKO9wNGvSZ4A91H7c7FnFMzErAVY=;
 b=kVugVezUdA0xmZSMfGoRRVUGubSklSBD73Ww9nmFceN7iWOoLJPsp1xgU78E3UDhbX2K4yFs2OO2sR9CbIWZBgmPAhEHCEr8GkJNlF56h12usGSuFKN7fs7g+XrQ72yKxNJXFrehhtBS6cwIaolE1mQMjuO/biXXaxvbnWvFp+M=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4624.jpnprd01.prod.outlook.com (20.179.174.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Wed, 4 Sep 2019 01:53:02 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf%5]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 01:53:02 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     David Howells <dhowells@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "raven@themaw.net" <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 08/11] usb: Add USB subsystem notifications [ver #7]
Thread-Topic: [PATCH 08/11] usb: Add USB subsystem notifications [ver #7]
Thread-Index: AQHVXzsMLREEIlZGOEClLfV6eehsdKcZpnywgAARagCAARAuwA==
Date:   Wed, 4 Sep 2019 01:53:01 +0000
Message-ID: <TYAPR01MB45441054C3956CCA7BBD80CBD8B80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
 <156717350329.2204.7056537095039252263.stgit@warthog.procyon.org.uk>
 <TYAPR01MB4544829484474FC61E850F32D8B90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <20190903093720.GD12325@kroah.com>
In-Reply-To: <20190903093720.GD12325@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5807f942-2c90-4679-2844-08d730da9ec9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB4624;
x-ms-traffictypediagnostic: TYAPR01MB4624:
x-microsoft-antispam-prvs: <TYAPR01MB4624B79926458D8E0323E6ECD8B80@TYAPR01MB4624.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(51914003)(199004)(66446008)(76116006)(6116002)(76176011)(81166006)(99286004)(6436002)(7416002)(8936002)(6246003)(64756008)(478600001)(54906003)(66476007)(66946007)(81156014)(9686003)(3846002)(66556008)(71190400001)(14444005)(71200400001)(4326008)(86362001)(53936002)(55016002)(256004)(229853002)(74316002)(476003)(14454004)(486006)(6506007)(5660300002)(102836004)(2906002)(6916009)(11346002)(52536014)(26005)(446003)(305945005)(186003)(7736002)(33656002)(316002)(7696005)(25786009)(8676002)(66066001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4624;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uNmXCM2YWDvC1x/S4vmwiutzGkD8n4K4kmO3b4qBnRSwqvl1qYxNkBKRHhpRnzU+Ut3PKzJA8+unUbE4oqJT4d+QEf79M1W6C+gjk8CuviqilfCxbC+Q926b0sQIWPcdlzHcrgfjiLUu6RR61KNw1cF0i/RT76lapNzp4kmeDCCYs8koMLUmAkthY8X1lcKSR6JvvhOfHpkQX/iuYJ2T4pPtlMCyQF54Z/UEA9D3wRJj3wXnF/mcwSNkJmq24ULxdi6CBXmoO5adSIXEMYnxump7oKAE1GjKO8aGXcdSZXGYTT1Gq4HQRl1nei+fFWWMZJNPi4zEi+LfcxrV+kyUM2ywYCkcprmoIOwPY9r4n7P3AnLxfNctW/5ICbq5KR2LSat2pcyRqd3LcPGjS3qggzcaNOJ0cs43vl76bfrSeMM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5807f942-2c90-4679-2844-08d730da9ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 01:53:02.0192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QgwGWGDHxAjp04N98FrcyX+g/u6VGoCfySVFCbZXeJ/ur22VorZxVX6lvxrSletlflzscrkcvb0VeghSPE7YBc2FZZl6G81ig3b7CA1m79cuTxIuAdnmaLmWX0yLQcnb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4624
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

> From: Greg Kroah-Hartman, Sent: Tuesday, September 3, 2019 6:37 PM
<snip>
> > > +void post_usb_bus_notification(const struct usb_bus *ubus,
> >
> > This function's argument is struct usb_bus *, but ...
> >
> > > +			       enum usb_notification_type subtype, u32 error)
> > > +{
> > > +	post_usb_notification(ubus->bus_name, subtype, error);
> > > +}
> > > +#endif
> > > +
> > >  static int usbdev_notify(struct notifier_block *self,
> > >  			       unsigned long action, void *dev)
> > >  {
> > >  	switch (action) {
> > >  	case USB_DEVICE_ADD:
> > > +		post_usb_device_notification(dev, NOTIFY_USB_DEVICE_ADD, 0);
> > >  		break;
> > >  	case USB_DEVICE_REMOVE:
> > > +		post_usb_device_notification(dev, NOTIFY_USB_DEVICE_REMOVE, 0);
> > > +		usbdev_remove(dev);
> > > +		break;
> > > +	case USB_BUS_ADD:
> > > +		post_usb_bus_notification(dev, NOTIFY_USB_BUS_ADD, 0);
> > > +		break;
> > > +	case USB_BUS_REMOVE:
> > > +		post_usb_bus_notification(dev, NOTIFY_USB_BUS_REMOVE, 0);
> > >  		usbdev_remove(dev);
> >
> > this function calls usbdev_remove() with incorrect argument if the acti=
on
> > is USB_BUS_REMOVE. So, this seems to cause the following issue [1] on
> > my environment (R-Car H3 / r8a7795 on next-20190902) [2]. However, I ha=
ve
> > no idea how to fix the issue, so I report this issue at the first step.
>=20
> As a few of us just discussed this on IRC, these bus notifiers should
> probably be dropped as these are the incorrect structure type as you
> found out.  Thanks for the report.

Thank you for the discussion. I got it.

Best regards,
Yoshihiro Shimoda

> greg k-h
