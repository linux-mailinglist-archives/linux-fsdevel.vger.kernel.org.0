Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDC0F30F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfD3Jdc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 05:33:32 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34252 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbfD3Jdc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:33:32 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3U9W6qk028054;
        Tue, 30 Apr 2019 02:32:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=mZ+nvmndlbaQ7SLtvyo7dLiIXEFydrptFcseZKbEb58=;
 b=uPpPn01pAy95qOdliusea8Z/qZQMlRZi42X5BiEyyNYYoAri5xoVVRoEUbV5WZDSfklj
 FgkdBIWdI9Ih1lFCy8YJwUrgi8Pd3jsv2atRHsmbqpmZEFvEmujABGY+aOWkR8koXNJD
 +saTUqOYnJhasihZofF4tGHFM8f1uINDijiTUkf99/92jmW+bNK0GKUfWbWlsk/GW8un
 R65gUT9yLxrpYTk1fh5foryHfprPEK1cL6OYnFtAqb/syBg7ytQVBh8VfZffZx3JQugO
 BBjE3F0RL9SKUeN/CdQH1CgZQaNmdg5a3dew7PQ57T/InJOJe5Mi8H45XpKnj3dpRIdf +g== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2s68rt27wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 30 Apr 2019 02:32:57 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 30 Apr
 2019 02:32:56 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.53) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 30 Apr 2019 02:32:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ+nvmndlbaQ7SLtvyo7dLiIXEFydrptFcseZKbEb58=;
 b=rTg6vgKoesJnTPKM7e5WvVXNpsGvE3hXIevTIAKmfM7v42G3ZJxA31lQjho8MX7YgruQu/9yowZgv2fF16/LbFMpBevHjmKerN2V6VK835hJupLcXGXbxOKiwEv33D9qgvflrBA27d/bl1/cv5ZBVx7Hd3ELtW0B6NjZhIfwMpU=
Received: from DM5PR18MB1578.namprd18.prod.outlook.com (10.175.224.136) by
 DM5PR18MB2117.namprd18.prod.outlook.com (52.132.143.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Tue, 30 Apr 2019 09:32:50 +0000
Received: from DM5PR18MB1578.namprd18.prod.outlook.com
 ([fe80::28da:f8bb:4901:b0aa]) by DM5PR18MB1578.namprd18.prod.outlook.com
 ([fe80::28da:f8bb:4901:b0aa%10]) with mapi id 15.20.1835.018; Tue, 30 Apr
 2019 09:32:50 +0000
From:   Jan Glauber <jglauber@marvell.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>
Subject: Re: dcache_readdir NULL inode oops
Thread-Topic: dcache_readdir NULL inode oops
Thread-Index: AQHUgFzbL+WYl59gXkeFkBEthHHxgw==
Date:   Tue, 30 Apr 2019 09:32:50 +0000
Message-ID: <20190430093234.GB5883@hc>
References: <20181120182854.GC28838@arm.com> <20181120190317.GA29161@arm.com>
 <20181121131900.GA18931@hc> <20181123180525.GA21017@arm.com>
 <20181128200806.GC32668@arm.com> <20181129184950.GA7290@hc>
 <20181130104154.GA11991@kroah.com> <875zwe389q.fsf@xmission.com>
 <20181130160852.GN2217@ZenIV.linux.org.uk> <20181130163228.GA10964@arm.com>
In-Reply-To: <20181130163228.GA10964@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0196.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::20) To DM5PR18MB1578.namprd18.prod.outlook.com
 (2603:10b6:3:14d::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [78.43.209.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59a869b2-de70-42d7-8500-08d6cd4ed038
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR18MB2117;
x-ms-traffictypediagnostic: DM5PR18MB2117:
x-microsoft-antispam-prvs: <DM5PR18MB211739A0B20D2F9A21137961D83A0@DM5PR18MB2117.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(136003)(396003)(39860400002)(376002)(366004)(54094003)(189003)(199004)(66066001)(7736002)(305945005)(256004)(14444005)(99286004)(76176011)(102836004)(71190400001)(52116002)(97736004)(71200400001)(6506007)(316002)(54906003)(386003)(8676002)(33716001)(478600001)(3846002)(2906002)(81166006)(5660300002)(14454004)(81156014)(6116002)(68736007)(8936002)(186003)(6246003)(86362001)(6916009)(53936002)(4326008)(93886005)(1076003)(6486002)(25786009)(6436002)(6512007)(9686003)(476003)(446003)(66476007)(486006)(11346002)(66446008)(73956011)(66556008)(66946007)(64756008)(26005)(229853002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB2117;H:DM5PR18MB1578.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zwZJBWg0ZeAjLElcd2Nh4911+L9jc/VrZDmtVcxD5z18HMwpZpQ2vt+Cyu1sHwJR+iscnZVef+lzDIMOS/r3ET50M/G09sraZOLSIjLCT9POKL/+DfqjQZn7ws/1eL5ge+iwX/5MGqqXrpInSLJkWSRJNeJEJdfynNpKjNbdlDsSV8ZMtPoHBJy2H1pg5m/VBofGMoKTC8bdJBswkE2csShuXlcQ1eTlKuAQRhTlic7OgYW9VkoH8Gwcy06I4B2CTT9Mr6I0PlqKLpdS/OIJkjxwy3LtECT/oSe9k3r6HeFb2xY+Tb04KWZr84R2jDQ3Yd4Q++22BCwWuZo4w4OzEj0oNUGVqJ4HYFbgbXQ9MZMd/bYrkDZOUqo0zXjf/YOYJJ0tBYZ0xcpZK8APS+qSl6DqTB7QicPL1rYCZ5cxb/k=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <100D159D89054645952C8FEA98BF21FA@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a869b2-de70-42d7-8500-08d6cd4ed038
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 09:32:50.7544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2117
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-30_04:,,
 signatures=0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

On Fri, Nov 30, 2018 at 04:32:28PM +0000, Will Deacon wrote:
> On Fri, Nov 30, 2018 at 04:08:52PM +0000, Al Viro wrote:
> > On Fri, Nov 30, 2018 at 09:16:49AM -0600, Eric W. Biederman wrote:
> > > >> > +       inode_lock(parent->d_inode);
> > > >> >         dentry->d_fsdata =3D NULL;
> > > >> >         drop_nlink(dentry->d_inode);
> > > >> >         d_delete(dentry);
> > > >> > +       inode_unlock(parent->d_inode);
> > > >> > +
> > > >> >         dput(dentry);   /* d_alloc_name() in devpts_pty_new() */
> > > >> >  }
> > > >
> > > > This feels right but getting some feedback from others would be goo=
d.
> > >
> > > This is going to be special at least because we are not coming throug=
h
> > > the normal unlink path and we are manipulating the dcache.
> > >
> > > This looks plausible.  If this is whats going on then we have had thi=
s
> > > bug for a very long time.  I will see if I can make some time.
> > >
> > > It looks like in the general case everything is serialized by the
> > > devpts_mutex.  I wonder if just changing the order of operations
> > > here would be enough.
> > >
> > > AKA: drop_nlink d_delete then dentry->d_fsdata.  Ugh d_fsdata is not
> > > implicated so that won't help here.
> >
> > It certainly won't.  The thing is, this
> >                 if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
> >                               d_inode(next)->i_ino, dt_type(d_inode(nex=
t))))
> > in dcache_readdir() obviously can block, so all we can hold over it is
> > blocking locks.  Which we do - specifically, ->i_rwsem on our directory=
.
> >
> > It's actually worse than missing inode_lock() - consider the effects
> > of mount --bind /mnt/foo /dev/pts/42.  What happens when that thing
> > goes away?  Right, a lost mount...
>=20
> Ha, I hadn't even considered that scenario. Urgh!
>=20
> > I'll resurrect the "kernel-internal rm -rf done right" series and
> > post it; devpts is not the only place suffering such problem (binfmt_mi=
sc,
> > etc.)

I've not seen anything merged regarding this issue so I guess this is
still open? We see a similar crash (dcache_readdir hitting a NULL inode
ptr) but this time not with devpts.

Debugging is ongoing and we're not even sure which filesystem is having
the issue. Is my assumption correct that we should only see this when
d_delete(dentry) is called?

thanks,
Jan

