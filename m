Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F952C8BD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 18:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgK3R4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 12:56:10 -0500
Received: from mail-eopbgr770135.outbound.protection.outlook.com ([40.107.77.135]:55521
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727722AbgK3R4J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:56:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6rMHX8m08uyDIx7jT1dmhRxqQB+MCjoDDdU3pDqCzxaGSrGt30PkoB2/TdJrXhVeU9xS7+aDp5Y066PnM8EvRk5hs+D+C5MBVCEPUdp3mM2xDUR7zSTBLia3N+L377F7n0e1HKSG8P6WFLttf5rCMUB6xy8TfFfpWEXCRMoeVSxdDA64Gd0sXB0JDWtNOxO7I5iKwgd9KiMUqUcUyovrHIWsloDOaJYrxZlirvijEyW9FMQIAbHYNRx3UxPG8MgR559XggP/DPkHf/5YU3ryJTpSHfujerBGOcuYUzVtQMmcUNpYtCbegJu4CvYeqWJY9VcdKxImurNdTLIMBeWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmbndxrgOjwasNVtsc6NoHEw3oJ9cVCH7NzcSK19DqQ=;
 b=GSaFCBIQGSFMsB3nuS9RGZkzT/VgkhAmL5qlg43GsbbvwuTSeTAew99ZdzMA/FeHUoDe890z+dzTr8j2CcRPk8yPuC0FJ+vYXdBVnKyZFpNYgo1Gk1aHZUjjwwHZGReERfhcMMKRAhjRhsMiHaBGpAgsKJ3o9A5SwGauaj7m9kahvMc0XTC8JlaEwV78cQCiYs8CzZLlaZ1tSNqeSqUgDf2eNjCjfgHooPlnTGZFlTRROGQ7gS7G4iCJo4Q1zKRhQWE4XkqxXkqJxgQPBvdq9fu4KPqSLLyCKoX4PwNWn8c14Rz6Z5hv3cKETBldU2sv2Fey6t9shS0/r7kK51ZxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmbndxrgOjwasNVtsc6NoHEw3oJ9cVCH7NzcSK19DqQ=;
 b=P7sE04yeMzptHP/j+5hh42KqAPgpOmSDk6HUZV7EN1iTH+Krm4E5pLyPDpmwqSh7Gkm3iV7Hb/eEx4irtKy27MFZnzjihXWSEUQgaZqyRrMqtKe/FJtXwWD0hYX2/3AcdUWwUfVHRQtnXf7x7CF9gzQ/oOXp8JuDiYLn9eslxIA=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB1879.namprd22.prod.outlook.com (2603:10b6:610:85::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Mon, 30 Nov
 2020 17:55:20 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::1922:c660:f2f4:50fa]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::1922:c660:f2f4:50fa%7]) with mapi id 15.20.3611.031; Mon, 30 Nov 2020
 17:55:20 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Race: data race between ext4_setattr() and acl_permission_check()
Thread-Topic: Race: data race between ext4_setattr() and
 acl_permission_check()
Thread-Index: AQHWx0H46IJbaeOx6kqE1WhPUQrBkg==
Date:   Mon, 30 Nov 2020 17:55:20 +0000
Message-ID: <051AF232-4255-42B3-95AE-F8F64D66A6ED@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=purdue.edu;
x-originating-ip: [66.253.158.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94e622e0-54b3-405e-f5bb-08d895591a8a
x-ms-traffictypediagnostic: CH2PR22MB1879:
x-microsoft-antispam-prvs: <CH2PR22MB18794C00BFA18ABE916E81C5DFF50@CH2PR22MB1879.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BXjzX3vrhuxcbdNii1ZmivvHuTzHGL9E8pSmI8ZOIQxMV3nvoRnOXgHKJdjwmIOg4/trO1x/1z4pthBZ4hjOHD9hqObrb3mMUsQwI3MIfhEVCX+fHR//ktlWp0/mZU+1DlOiLzXuuEkq4tiBcnppaiSYOBpzW4q8Fz+lzOOxs5iXG371jPZzD5q8qPMzk5eeM+D0jrGldGEtFXUWEL6VxA3rjDLgzlLipycYtk2u2tocRvW2n2/m16Gb9pS/QQitlD4+lCFL2+x9EZDbwNMSJRruzf+7t6L5c1IoP6+RcfhV2EUu+DFsG35qmEFjVDMY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39860400002)(396003)(346002)(186003)(33656002)(76116006)(86362001)(26005)(4326008)(2616005)(2906002)(6506007)(71200400001)(83380400001)(6512007)(36756003)(6486002)(75432002)(5660300002)(478600001)(6916009)(8936002)(66446008)(66556008)(66476007)(66946007)(8676002)(64756008)(786003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?meOVs0jAImDoUZQG72p/vXChlx1CipoXRsCHpBYvLcF2QjFfL1Oy8ivOAzzv?=
 =?us-ascii?Q?Ufhsk+6ksVfay5mqyEWVG5nOPDOPG4mJ+JQbXiCWPhBCoKaAJDXDGP2PFBQc?=
 =?us-ascii?Q?YZCvifxAGlx0HqmXWpuoVDBNn/x4+VudPe0RB8dhRezcxZE7myPAfqJ0kzip?=
 =?us-ascii?Q?aAmy9u7NH/QqxZ2VhGEO96PsVea+dgTb695HKsAJ9g/o62Ied1YBClIiXOoH?=
 =?us-ascii?Q?L9ckCSqb7Aiwk9xKUKtyJ4X+G/AK1OspXoyuyVMOinNKvbTGiRJyzJi1sGSQ?=
 =?us-ascii?Q?s0QqR2V+y8N0x0s8qj1t6kgTe1YT1QonQaZkvl7r955NtwFFxbfeUOwPqjUF?=
 =?us-ascii?Q?uwxysSE0YqrUU1yC5j6nfUN7076TZicP+nVaORhmC9/38okTbn5ERaKOMtT4?=
 =?us-ascii?Q?gIMp8owe8uu/+jAY5/F6U2SghZEc84I0K6hkjNAGC19rXddJf3LyeznaHG1w?=
 =?us-ascii?Q?LipPKj/kbkpOquxOXQXoiJBLYXCtPyTdZss3cyj6HKj16z1+z/2IAz2uqycn?=
 =?us-ascii?Q?9wJNUMvyOjwy3vW2f/qNTSzmRgpw1yvN6gTO2Y/BaXjkMFPzv5TpW86Tj6xj?=
 =?us-ascii?Q?yOxT/0kTt1jgnKQ7u+pOoMM3hP0C0xpe2RvNyEWl/2K0/D6LdPRFFG8YBl3V?=
 =?us-ascii?Q?hyNeSsxl4y/TEBh2ZiGy5GWhd8wAsz2iBysw/nKM5u/8eAGK1oFvvVppnGr2?=
 =?us-ascii?Q?b2eFLWo5puQ6USj7ToccPgviPvsW4V1vW3MSR0bcH4fhiCZajSndx7/boRmF?=
 =?us-ascii?Q?XWcNHN6kqhOaNvfgxmzfV0Ge7sjN2eq7XyNyaJdWmQTP7V7Y0KetvuARu1v5?=
 =?us-ascii?Q?t/uthKxHdDd5y0pK6qXqbGuAZTQQ4V+H26gEQJ31XElArKKfXh4jPBywOeEA?=
 =?us-ascii?Q?ZiCiciZmSktD4zufUNimOAuYPIRCR5KDbum5lP2ImG46JQXQmD34kEm+NrWI?=
 =?us-ascii?Q?jeP+sQcAzczeviotRqcPzzHN0+jbfyyOTh1SFIkb0jEhcSUfoGvyzHYd/xGE?=
 =?us-ascii?Q?o1kS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8412FAB5B5DE8F4B910A8E47934E7195@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e622e0-54b3-405e-f5bb-08d895591a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 17:55:20.2021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQ3NnP6GAjKxOi9oWE6bs12oiJXtcSumIGfYJSUHpWDATrmDNmmaebQ+7EEUvJOJVka0YDphfnW5vxXZIQVD9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1879
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We found a data race in linux kernel 5.3.11 that we are able to reproduce i=
n x86 under specific interleavings. Currently, we are not sure about the co=
nsequence of this race so we would like to confirm with the community if th=
is can be a harmful bug.

------------------------------------------
Writer site

 /tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/fs/ext4/inode.c:5599
       5579              error =3D PTR_ERR(handle);
       5580              goto err_out;
       5581          }
       5582
       5583          /* dquot_transfer() calls back ext4_get_inode_usage() =
which
       5584           * counts xattr inode references.
       5585           */
       5586          down_read(&EXT4_I(inode)->xattr_sem);
       5587          error =3D dquot_transfer(inode, attr);
       5588          up_read(&EXT4_I(inode)->xattr_sem);
       5589
       5590          if (error) {
       5591              ext4_journal_stop(handle);
       5592              return error;
       5593          }
       5594          /* Update corresponding info in inode so that everythi=
ng is in
       5595           * one transaction */
       5596          if (attr->ia_valid & ATTR_UID)
       5597              inode->i_uid =3D attr->ia_uid;
       5598          if (attr->ia_valid & ATTR_GID)
 =3D=3D>   5599              inode->i_gid =3D attr->ia_gid;
       5600          error =3D ext4_mark_inode_dirty(handle, inode);
       5601          ext4_journal_stop(handle);
       5602      }
       5603
       5604      if (attr->ia_valid & ATTR_SIZE) {
       5605          handle_t *handle;
       5606          loff_t oldsize =3D inode->i_size;
       5607          int shrink =3D (attr->ia_size < inode->i_size);
       5608
       5609          if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))=
) {
       5610              struct ext4_sb_info *sbi =3D EXT4_SB(inode->i_sb);
       5611
       5612              if (attr->ia_size > sbi->s_bitmap_maxbytes)
       5613                  return -EFBIG;
       5614          }
       5615          if (!S_ISREG(inode->i_mode))
       5616              return -EINVAL;
       5617
       5618          if (IS_I_VERSION(inode) && attr->ia_size !=3D inode->i=
_size)
       5619              inode_inc_iversion(inode);

------------------------------------------
Reader site

/tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/fs/namei.c:306
        286
        287      return -EAGAIN;
        288  }
        289
        290  /*
        291   * This does the basic permission checking
        292   */
        293  static int acl_permission_check(struct inode *inode, int mask)
        294  {
        295      unsigned int mode =3D inode->i_mode;
        296
        297      if (likely(uid_eq(current_fsuid(), inode->i_uid)))
        298          mode >>=3D 6;
        299      else {
        300          if (IS_POSIXACL(inode) && (mode & S_IRWXG)) {
        301              int error =3D check_acl(inode, mask);
        302              if (error !=3D -EAGAIN)
        303                  return error;
        304          }
        305
 =3D=3D>    306          if (in_group_p(inode->i_gid))
        307              mode >>=3D 3;
        308      }
        309
        310      /*
        311       * If the DACs are ok we don't need any capability check.
        312       */
        313      if ((mask & ~mode & (MAY_READ | MAY_WRITE | MAY_EXEC)) =3D=
=3D 0)
        314          return 0;
        315      return -EACCES;
        316  }
        317
------------------------------------------
Writer calling trace

- do_fchownat
-- chown_common
--- notify_change

------------------------------------------
Reader calling trace

- do_execve
-- __do_execve_file
--- do_open_execat
---- do_filp_open
----- path_openat
------ link_path_walk
------- inode_permission
-------- generic_permission



Thanks,
Sishuai

