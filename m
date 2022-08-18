Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF8F598B4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 20:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244854AbiHRSeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbiHRSeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:34:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896814505B;
        Thu, 18 Aug 2022 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660847661; x=1692383661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K25oSH2Gh50mswoDvUSvM4ttLrw2auvu7eqcNvqBWJw=;
  b=TGi/OrMInU0Zm28020tSKqikxCxpvXwvPk03YCCkzzrhJcd6VfDOSvYy
   vyFx7XoXS1httEFKhQ9SDbyk1IeGh3INLZ22VXeprDDixLqK38YKgAAif
   X/3JVoLX/NAqhd1F5y1QTDcMJtGlqLNZQ2RkNk4ra3HgrtQg0ruupMxNm
   uCM5OEVAdPy/XYtQm94YMWB5pykasHeJLkPxFX+WI5lwT5rTLNlA0LKe6
   lNkwAIk4MhRptXy9we5AR0HVLesSpRgeF4hyR0BwAMOex7K3OE6HKBrzD
   c5Dv95QPt3Me7vevqYmnyqy0PqweaKc36Qyoi9+W6w7QWmzl6kNDDwZCz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="273231335"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="273231335"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 11:34:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="668232399"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2022 11:34:21 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 11:34:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 11:34:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 11:34:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 11:34:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwqduRJgA84f7FHHIcWhxgehD8XczFhi3hyDy6XdZYsaOgNKyV0zcWMX7nG+M4I7RZH2GK4EoItNyfnWEPQXNiwUd7ud1blhj7EbQhqj1gb0fqFXCAM9t47/RDjg8W/B+aHupYANZdUe3ApTjiPOWtJt0+9HRJyymaxopNIDEOcCLyZ6xIVkpZkRiHwaw8vS31eQWPiWmXrpx6Hd94B4VdisBVvMUfUeP95DRe273/Cekfvaq1FeIKLeZZXxcMfZVzcRXuUM5NxrzRbW03sQCrwVjin5xqjRvcaYv1tJ6aHr/ZNhb+SQT197elMdvj5ljphTHZ83qBWGudjVqKSWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fxGCSWZf7EVg02kyEOHGhGnWmbTgDgSNkaaVQ7HZYU=;
 b=gWpezVTq5v6wfb7jatMF/I0z2F1xwfcbym+oGdhx/mqbYWkbhYi+xdaOibMfd6H+cUOjSIWI98VUuKF4Ti8EwH+/fKk+Cwn9ZxOLPcZxc5Okw+/Q9wM9hdYYeo7okc5DgFvpixAzsWmMaEygDSvQTsMAC6HnlZp8/eWmvrTLtKTkeISLA7NzgNINdA6Eo63FyBS2qt8RifzcBVOyVwevsmDIu/orEMxHiS+YU0y8YClykLXepF1NiBR6nRujJwngdXiZ4CcR/PrjcLP+oYMIgPQ5/MmIKrfWCe4MJHBDnmT5VXuGBh3WWRGWvRA3DhbV21QxN5hlSymHfy90ehLLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6353.namprd11.prod.outlook.com (2603:10b6:510:1ff::8)
 by CY4PR11MB1925.namprd11.prod.outlook.com (2603:10b6:903:128::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 18 Aug
 2022 18:34:18 +0000
Received: from PH7PR11MB6353.namprd11.prod.outlook.com
 ([fe80::39ab:8ef4:a161:4875]) by PH7PR11MB6353.namprd11.prod.outlook.com
 ([fe80::39ab:8ef4:a161:4875%7]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 18:34:18 +0000
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: RE: [PATCH 3/5] ->getprocattr(): attribute name is const char *,
 TYVM...
Thread-Topic: [PATCH 3/5] ->getprocattr(): attribute name is const char *,
 TYVM...
Thread-Index: AQHYsq6VLnYzoVSg40OpFYoc9hiea620/CXA
Date:   Thu, 18 Aug 2022 18:34:17 +0000
Message-ID: <PH7PR11MB63534293F9BD648D0FD0DB3EFD6D9@PH7PR11MB6353.namprd11.prod.outlook.com>
References: <Yv2qoNQg48rtymGE@ZenIV> <Yv2q6/bVtQgB07k4@ZenIV>
In-Reply-To: <Yv2q6/bVtQgB07k4@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a75fef27-ed35-4d52-39d7-08da8148428d
x-ms-traffictypediagnostic: CY4PR11MB1925:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khPZsQUKaZuWZBx/Ek0kE5SDbCkMXIddviAeH+ETWLQZ/slsCNU67nSWdc/S7edYnGPuUbayry/a+YdhiN4yxtMa3SWBu6j+QgMJbSnnkHys8O1fCMxJwzymT07wGVFnTO6k/jtcJpAuL+Bkj+vt+pOOdAaaaQjW8u8N7ezYx8hzXaP3lERzUCBLCFWRKgZuMY7jw61FLvOU676HqfA7RbMAHLFgvCuIRAJ3TTQzLnHyGc6jRZPTmVPlphNtIeUYT9fwjBj5eBxrK1I4he3VveUVIoeK6Kcs1AaJ7atIyTF4Z+swkX4w6TvV30weolK1vq05YKHft2pIOUkNsVMJfuxmK4tG+OAbRp+wYtP/RfEEfcC8H9Zme3l3lM5jgp2Wrkibsz+A9D37GhXTc0TqNcy3D+ZNg4KdFSZlJKutpNevpqDIUZZa4+CKhrcvcJvtz39qAVRBJIQ3iYmjkdAjEf8cKQHN45jKZTXqST9KhTPknTcs1DSuB3zlhXheL4NoGIwqJx1y2XBX1OoTSqql0W88xrJONaVlxbl7cDOklHzPGw7luwks3P1evxdEHzKK2PBV9TPAxNRLjxMXnU6Y2mf0kmyxXI5r2MZFvzrrPsPZkWHb9QcgFb0YkJY1ZbT9qtRVipJ1IxUwGaR2BDrS30+UOzetT6hRLkapLwJaT1TqExZdrApKFIr3J5GUpofT8ObhFrpE1Dc74IzlEKMf80ghlsO4o6+/CeDgFpus0Q8AIPDERrk4FuiIB42IGqr+/ehWLXecxf9bnQEnKrntJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6353.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(366004)(136003)(39860400002)(8936002)(33656002)(83380400001)(52536014)(122000001)(316002)(38100700002)(110136005)(478600001)(38070700005)(55016003)(54906003)(7696005)(53546011)(6506007)(2906002)(82960400001)(26005)(41300700001)(86362001)(9686003)(64756008)(76116006)(66556008)(4326008)(66946007)(8676002)(186003)(5660300002)(66446008)(66476007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lqhXaG1bc9NP+3Qsl3aY8c7I4cN55xdNhQDEZ7xAJvg0z2TfHtME5n/E1KIC?=
 =?us-ascii?Q?F7yC7i1pZV57KOUKtixkHm5ooK2KGMWo2udaNr/+HD9CMbzTO3HC5l2xu/uy?=
 =?us-ascii?Q?ZDQIF883opef+MNnMdH8TVyyt1P4fMBTVgAXYEyHpKss0vVGNGIH90hCZIxx?=
 =?us-ascii?Q?OENovdw1CnU45qK42agG6c5mvsGLZ+CoW7ZWkhvnydA5fXSmM2Os7zEt/azl?=
 =?us-ascii?Q?AZTMzPHs41OFNE71uFLG/TWEb9lByrJjPMoHXC3HgD+wKZB4NhAM+Y+ngTZy?=
 =?us-ascii?Q?jcg534GBnwWWhyMaESUkNINOtL/7QnjDm/dCX7LZ+v2UcFGpZOBVK3Vl4V1K?=
 =?us-ascii?Q?/zdTz81TPFRXgUAdVMiWzeRYLRTdhvpgstTSN3zh1o6+FIaL0EqrSAcI8UrZ?=
 =?us-ascii?Q?SwJCXDrruPfowfET3VB/GtFR7PHoBItvqcpQt4j+f/CtA87LUOozL8/Cwmiq?=
 =?us-ascii?Q?xuYFVw+RfzPcuNTWhmiBjRy8Ov9RFxf8mVOEAa5iciF9wA0w0rHyn1ASEVeA?=
 =?us-ascii?Q?Yd0m0SRGd/J8m+oZTZ/YZS1LbpfaaQl6nFWVBNdH2b+5FBa2CWDmn2kotDuT?=
 =?us-ascii?Q?LYVVEDji+We+G2UX8cMSmpeF+El6mZyvfV2sedRgxg9LOtuS1w25Y69vum1t?=
 =?us-ascii?Q?IL7fPR7VYhH6dizMi2RfIPEYKFmW74Sf5wWTYiButPsyR7MfVV/A5Ee9IPJ0?=
 =?us-ascii?Q?Spm9fiAvLBuVigLJiq/uaasmedcm4fCZY95o+VkHSFzk6JYNqap29qwK5Wmm?=
 =?us-ascii?Q?0Irun08bz37TQWUrk8dmcNPF0ljZnoIH08JSp5qRrfvmXuCffepwEJPMixGg?=
 =?us-ascii?Q?5S7xNv+ued3yoeP2W6TtS/jTjxydL4QoOFvsUKstU0xRjhHb47CGtbBAd1M3?=
 =?us-ascii?Q?TEgncsycgC5A7UMop5wqr928UI3cMtxXjfrZGHJYV9CAIQ4gYYq26I56iMQ2?=
 =?us-ascii?Q?ohUqpoNGIJoZrdwDei6j4wdMnnYu2ULhvnugCn2Kac0AEc6/T48wSVlzHnxA?=
 =?us-ascii?Q?xR3S4uNwVMgIkS3wYeYT+2RJtAoFN6Hz5CbWOB0HMskn0GJ+4LVPfUh/yaa2?=
 =?us-ascii?Q?UivPc6V1vsjPoil4ewZ0c8eBtVTo9K5Kc5ATc7IrT41C+xBZs7d+Vy5nHo0B?=
 =?us-ascii?Q?CofuAUdTAzLP24OiqLcPfFsoviAh0FyGLg1USOijo2V9olZZRriEJ4nIsL90?=
 =?us-ascii?Q?iB/SqV3J1HkQRbyyDWDpVPLgTA5WSPcOCrO02hEiUl+9NTqq4ZKF6vXkYVph?=
 =?us-ascii?Q?V/HrxDus1Uk8Akb6U5JtSzm/8wsCcRyanlXCYFVRCKK4xdEZC2ceg29bvzMS?=
 =?us-ascii?Q?xhMTIBGhVBMQjbtBemwbcGjgCNu6xi3RUxwvdx31YMrOnKi1LiCB42jB/+h3?=
 =?us-ascii?Q?1oN6hmQshude4bzQtOgk14IM1GVsUR300rMJDWnGtHnZWF5fn52RZq2gVx+j?=
 =?us-ascii?Q?9wYM5n5vbqaNxYpraS6OjHliis6ZiVRWLUKxXcV1BvZAD8iww/B4FacAVlx5?=
 =?us-ascii?Q?60PIz9BnO79taChAoCVMRWGdrYXoVfh73dRMQBWrI5Fmez9b75mez7UbriLL?=
 =?us-ascii?Q?NVAEF1dzm6KXnPM3thqyauzIWhfXhAad2RDQVjn+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6353.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75fef27-ed35-4d52-39d7-08da8148428d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 18:34:18.0057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHpLCBxhtWh1nw7xjJGGH945PKZFtmX8S96WKcp8nvliox1Br9r5rytElypMHd+emQ93CJVw53A6TPfM+3MvGI7cLytoM30sN6T+rwT+vfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1925
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Wednesday, August 17, 2022 7:59 PM
> To: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH 3/5] ->getprocattr(): attribute name is const char *, TYV=
M...
>=20
> cast of ->d_name.name to char * is completely wrong - nothing is
> allowed to modify its contents.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Could we please have the LSM list included when making changes in
the security sub-system?

Thank you.

> ---
>  fs/proc/base.c                | 2 +-
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/apparmor/lsm.c       | 2 +-
>  security/security.c           | 4 ++--
>  security/selinux/hooks.c      | 2 +-
>  security/smack/smack_lsm.c    | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 93f7e3d971e4..e347b8ce140c 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2728,7 +2728,7 @@ static ssize_t proc_pid_attr_read(struct file * fil=
e,
> char __user * buf,
>  		return -ESRCH;
>=20
>  	length =3D security_getprocattr(task, PROC_I(inode)->op.lsm,
> -				      (char*)file->f_path.dentry-
> >d_name.name,
> +				      file->f_path.dentry->d_name.name,
>  				      &p);
>  	put_task_struct(task);
>  	if (length > 0)
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 806448173033..03360d27bedf 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -253,7 +253,7 @@ LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm
> *perm, struct sembuf *sops,
>  LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
>  LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
>  	 struct inode *inode)
> -LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, char *name,
> +LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char
> *name,
>  	 char **value)
>  LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_=
t
> size)
>  LSM_HOOK(int, 0, ismaclabel, const char *name)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1bc362cb413f..93488c01d9bd 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -461,7 +461,7 @@ int security_sem_semctl(struct kern_ipc_perm *sma,
> int cmd);
>  int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
>  			unsigned nsops, int alter);
>  void security_d_instantiate(struct dentry *dentry, struct inode *inode);
> -int security_getprocattr(struct task_struct *p, const char *lsm, char *n=
ame,
> +int security_getprocattr(struct task_struct *p, const char *lsm, const c=
har
> *name,
>  			 char **value);
>  int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size);
> @@ -1301,7 +1301,7 @@ static inline void security_d_instantiate(struct
> dentry *dentry,
>  { }
>=20
>  static inline int security_getprocattr(struct task_struct *p, const char=
 *lsm,
> -				       char *name, char **value)
> +				       const char *name, char **value)
>  {
>  	return -EINVAL;
>  }
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index e29cade7b662..f56070270c69 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -614,7 +614,7 @@ static int apparmor_sb_pivotroot(const struct path
> *old_path,
>  	return error;
>  }
>=20
> -static int apparmor_getprocattr(struct task_struct *task, char *name,
> +static int apparmor_getprocattr(struct task_struct *task, const char *na=
me,
>  				char **value)
>  {
>  	int error =3D -ENOENT;
> diff --git a/security/security.c b/security/security.c
> index 14d30fec8a00..d8227531e2fd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2057,8 +2057,8 @@ void security_d_instantiate(struct dentry *dentry,
> struct inode *inode)
>  }
>  EXPORT_SYMBOL(security_d_instantiate);
>=20
> -int security_getprocattr(struct task_struct *p, const char *lsm, char *n=
ame,
> -				char **value)
> +int security_getprocattr(struct task_struct *p, const char *lsm,
> +			 const char *name, char **value)
>  {
>  	struct security_hook_list *hp;
>=20
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 79573504783b..c8168d19fb96 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6327,7 +6327,7 @@ static void selinux_d_instantiate(struct dentry
> *dentry, struct inode *inode)
>  }
>=20
>  static int selinux_getprocattr(struct task_struct *p,
> -			       char *name, char **value)
> +			       const char *name, char **value)
>  {
>  	const struct task_security_struct *__tsec;
>  	u32 sid;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 001831458fa2..434b348d8fcd 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3479,7 +3479,7 @@ static void smack_d_instantiate(struct dentry
> *opt_dentry, struct inode *inode)
>   *
>   * Returns the length of the smack label or an error code
>   */
> -static int smack_getprocattr(struct task_struct *p, char *name, char
> **value)
> +static int smack_getprocattr(struct task_struct *p, const char *name, ch=
ar
> **value)
>  {
>  	struct smack_known *skp =3D smk_of_task_struct_obj(p);
>  	char *cp;
> --
> 2.30.2

