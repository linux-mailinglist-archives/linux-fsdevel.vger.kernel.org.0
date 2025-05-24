Return-Path: <linux-fsdevel+bounces-49806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CCDAC2DA0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 07:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8C77B9629
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 05:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8511C5D72;
	Sat, 24 May 2025 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tiPu/j8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9261459F7;
	Sat, 24 May 2025 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748066223; cv=fail; b=Dhifz1I8TtulTCWB2FLaM6mNGm4njh2wnKfF0gKkzWwrV9UR4cjR0IRAx/AUfMFnFsVM6IxIBwx78cFK8qFfPpFk9VxynKrQT7oh9ATpRPxC0/xFBk3YmbNIxJE0uPsfkNU/1/hGRkrHRAV/cEl1ebHx1m01V1OP5Ln1m/HpJ+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748066223; c=relaxed/simple;
	bh=MVXE+DBMgcdHm4lITLW6f9rxNHVvGOnFY8Yfeajso20=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VgPf+SjmZom4HSDNW7DkUpw2xe0DI3LHvzKD7hY2eb+qB5IYG76HNCrPQUZ1B8L1/jLX+3TEZKLalttU+aeIrAQjgtabYhisYYz9cy4WS1O295LdWXxHg+kGy5bINm3Lzbdxp1sk2aR6oITIi9gRqF0/i/MZ4I4kqwpzk15mC7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tiPu/j8J; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwhzYlTJFnKiAC9mRE/UwrRprJoa0ZXnLWPN6ntNI8O4reg6E8U5JTmkenZAAkoBedpwK9scmzlaI5w4os/MXSQNqHQIsNfPdXoBZ8EHx+4GsrY5B3f/AL/KHrlNqrFQY64SGGgSx8KF17zJoQnCZtOc/LTogU8KmhdFLJOdtLeMM1kto9E79Y1Wq+Bo2McMyS28PKNnf/aK+t8cHa8GKqA8u0Q9z8yrGL068mnJEy+vIKkTBNhUC/KeTNV7y7W+KRnRkCVYWMOX7/KrwurcPey8YhxAgQ48WaGWsRJy+bSYL6c7TGSMmpcGLOr9uglZLVLrOx4BQ2j1x4WG6rSibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHxLNxnT/1O8Uf/AdDg0bIQWm5po7QaIYYYaoIl/e9Q=;
 b=mss5NsJyHwlA8zw8NGfguoFzIoTftxBVrK7A+DbYe0HHnpS32zXX/9nteXeHjfJ+uZYRSo61UKgXhMFbkZyeslcdXO2e0kCAT+Wya1PuPxBHB/pgHLRRGyXh548+IaMT6EAZukbqBI3Eyx+mlSHlEDYDmJpsmPfAD2qhA4pkKr1hY5+Rc5Z0Yu7WlN1NdjOLf2ROITr1XR3HXl4Hv3eY6rSlU5wC/MmrSJezRc/ntxN7OQOeqUEpTJbA+iWrvrFKy15Eo5VdGs2PnjJaYL+eWQmgFEMiUwK3QWSUSMl9o8zgMOZkDTY8L4X2Qj92r/hXsxkCh3ipfDGRTPq2q+TMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHxLNxnT/1O8Uf/AdDg0bIQWm5po7QaIYYYaoIl/e9Q=;
 b=tiPu/j8Jnq0FTiGVuSJpuwEDc/aDy5GOzBo3xjuRN3iXM+8sMsiQSYxy94QPoxXJPoxUAPiLOTYmLLdyV3yb86ZOnobvQsR8AbPduk+pPt+aUZtEgsQjA7o+Fg/i9KIYBWSEgTLFrXDIFCC/bfTZbksZrVLd2qQ2MmYs1Ycpt2+UtLVdHKPAb0VETc8An+gmSCv6pR4/8aaJ/jG1pMiWUPGGkrm8IPoG87EHcjRzQzMeo9eBZksfySLUVA5i5P+HXb5sPf6A+N3SzX6U61hfH3RLzSUbL00p/siPW607gHU91XByDUwlRI7gqx+yJU51IoIHpU7LbPr1FzleWjD81g==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Sat, 24 May
 2025 05:56:55 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8699.026; Sat, 24 May 2025
 05:56:55 +0000
From: Parav Pandit <parav@nvidia.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: Jan Kara <jack@suse.cz>
Subject: warning on flushing page cache on block device removal
Thread-Topic: warning on flushing page cache on block device removal
Thread-Index: AdvMbvrhAHapLL5SQLSXHQ+FhiQIJw==
Date: Sat, 24 May 2025 05:56:55 +0000
Message-ID:
 <CY8PR12MB7195CF4EB5642AC32A870A08DC9BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|LV2PR12MB5727:EE_
x-ms-office365-filtering-correlation-id: 4bd8070c-c45f-4956-56e8-08dd9a87c9b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TtwNanSch5rqNIZp524TkJA0FTMtuSNesC/xyypIylLcHF1jZ5LgimAZySUu?=
 =?us-ascii?Q?0q5dbJHwEHTDjWM4hPSBKnNuggA9p51yEjfF5SYxTD6ZGIuM7AxHp5nmWVXD?=
 =?us-ascii?Q?qReMg5NtlboFXBxDZ4SBInkkijQDJgmbJSHUeEAmYmlgC5SpsjVqj2cNY//p?=
 =?us-ascii?Q?MDZtUDK5O9TBqueqGhMvgUiMsyemmbmrjgToJP1EiyrqG9laeIq1BdHtQcFn?=
 =?us-ascii?Q?bsb2dioIS1r3O+5xvzMFshHR29IkdL+wdRW3ZYaPXVpzY7mj5Pmmhwhq14Yg?=
 =?us-ascii?Q?gQZeZBm2QQLQTvjyI6B6OR1vfOoQSWrobuHMgwnA5q9YH/Gm6J4ixWSgABMa?=
 =?us-ascii?Q?GD+INhLHvpYshb0LZovOgnMDtYBiOrzSBb+ZATaNzME67nga/uFOq1ILrKPV?=
 =?us-ascii?Q?egDQiIVUwHejkVbGHynALSGh2PANQ79ODvPc/tm7wpqAul6XpdOidB05pZ4i?=
 =?us-ascii?Q?EyeU+3PL7qqjqGcb0/m+ZJ80BNbL89wMAOWvMPVynAdG5DnIqEXI3kjm3bsm?=
 =?us-ascii?Q?Qp3Mku/XX8KMrv5tB4cGoARjUVd0BwxEUENImG2aekaqOZR40y+O9omdl6xQ?=
 =?us-ascii?Q?iV7dDXzXVMhTuwhKJcRTXtby42tJLfA77cCCbcobvWWSCrxwi5+eOVcsv4QW?=
 =?us-ascii?Q?kxeXgR/wTbnHwvKJLyhLjENt3b1bvpvLQ6rIG3W/U/Kd+Hd8x01jjJRRW3ax?=
 =?us-ascii?Q?esoYOgFRB/+5mjnkfsKwoam44wQVlmuRxD8dABDUeHVsKlIfcOXPXxChITTM?=
 =?us-ascii?Q?9r+m2OWz64B/U6sAuUytXv/f2ySXAmUaShVuHyvle2VynKZXFw0Ju4OABaYY?=
 =?us-ascii?Q?SyNUU9qggMyfMYnNAuXejtEsWKez8hYeRHlooRlVekOBNJpbW9WSXU8fPuVO?=
 =?us-ascii?Q?0KgpSjK7dCdtuGXq1f3uYM4A+JNiCjk+ANb4LN2hbcVWIdbD5YBFmIR+JtoI?=
 =?us-ascii?Q?camwndiGA9yXCbbhUFoNhapR/vKrAEZUAD80//4odTWWEtAuXq1PKq/y+GDB?=
 =?us-ascii?Q?GDnAfOH4CymhPkOLMC4FKNNqQPvxW7TyK0GKeFfDO00K326BV3oNXfrghwiE?=
 =?us-ascii?Q?NE9AzKp8yzqRYSxVBdcxMFaypkJRaMfbv34aGcpNju9QksqUKT3akc9tWUc3?=
 =?us-ascii?Q?qcVIfgvfpeUN6a6mHr0CJRHLEHpsOzgorLBd3dB9F09RcecrJ9pUxWybKitb?=
 =?us-ascii?Q?WcToMuam1XaCayc3SGvHg16ouHd1+aodHrElkCFK4qAE/r2JiZnKWqz9MQjK?=
 =?us-ascii?Q?I37XXY7OTzT7sGHeksL/38B8tpyA55NIJAnSGxgJk7hwhmO01+T22oyRXfwU?=
 =?us-ascii?Q?02Sr+HVh737FsY+A9OPQ+0+sC8ELh5JXoBxUAz9gSsoV8pc+3so0jiNGDXLm?=
 =?us-ascii?Q?BDUtevK2sNRmCRB2B7R6NUO0ITZTW1OcLDi1SfR+V5d+RcELKTSD3VwmNrSa?=
 =?us-ascii?Q?bfEbbjrPmS1t08czAqY7EaY+cmynUDmGfP2GQaLVXCF/tEkBAoiSJg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nNAGeU2ISI7QSazczT5IqJZ1pGu3Sw7j+MbuF/VsuCL6nuWgqMRN4rxjLvaX?=
 =?us-ascii?Q?YB+v5zPddT1Z1b+UZpBb6KZXJLji1fRdsae9nEElJamkjdA0pvaBFurb5Pdp?=
 =?us-ascii?Q?q0mtSz43G0As3xMc4Nct6x0XwYXXwRpVC9eo1GKWYco08HptzCcnX1BnPBqk?=
 =?us-ascii?Q?iyLCwV8XWavu0GNhOelOC+iBoQyZs7pGsVih5MdD8aTajH4krK7zWPexnu4s?=
 =?us-ascii?Q?jKoZ80LmxjYcEZy3xzt2aiivbDTW163Hk+eChShQoy45++BALNqMBiuYYnZ2?=
 =?us-ascii?Q?0STWkFaiJ60jA4Zd8f5KCA/vQzBbsG7ks0CoKViLZfev5dvFMh0ZD6AamApA?=
 =?us-ascii?Q?MP7/ScBUzlBT3Jayvmo8ViJ34bV0HbqgBc+Zl+qVCzZxy/48c0Pw61ShYFlV?=
 =?us-ascii?Q?AyuwDKdiwDQgMK+4QUtGSoQgK0JwiBuiVYO7qz8iRuCEY7I+OTLpZ2XPPeFj?=
 =?us-ascii?Q?QGMIHwkvIlyqwhw8xn9Y0v9wIJE0Gb9G8Ra+IIZjkycUM6vUxJ4Ik0X/vbRp?=
 =?us-ascii?Q?aNlxyq7TrwUiysEvhtI971CyjqwLt6Kdc1TawaL/vpnLgF7H/MRyb6g3pzg+?=
 =?us-ascii?Q?MtCGFDcR/nZv7S5leOatlOTAv2rZdpOIGF6E2KBMEDehIWPV5THPmEyjN1IN?=
 =?us-ascii?Q?/95GCHvd/bUammgsWQhl0Segw/fMdZSHH9naEyykaKp6FJ/J2BtdIoNCGRy5?=
 =?us-ascii?Q?ywVg1FwLDFIseTulKoom6w8rFCT0JrieZMBAq6oxhbWMus22H47m6DUC/D8U?=
 =?us-ascii?Q?e6QdtWOc1ci2el7QCe1OegyRtzOb2MVkYc9kN7v4S8Ks6ltp0fvYiS0YbGUI?=
 =?us-ascii?Q?D44IRWqODGK9brc18Mb7L9hYu0aJP/+sgb3LxPRR5pzdzXzb+JJsJ7UZF7vi?=
 =?us-ascii?Q?sFvudxbzoF79hoEUzk3YEKAf0B8lPwWH+Q6CeI3T/OUqgQxA4SgkgvpmMmDi?=
 =?us-ascii?Q?ziXHG/Mf8+dI0AjXIPEfaU0oPVxiV9mCHDY9EAQO4hnkg9b4zbdsA38rBGk9?=
 =?us-ascii?Q?6Tfkf6Ugx5gLjTjKH5hSZrA8U4EOBYoPliIYCMBsFeDkadu2U3vEhn5E+h5O?=
 =?us-ascii?Q?2w22HAbbb3/KljYffyE6O8BaxXbEm18j0VOTUfyRJk5GVZk0IyVR2GHQnMAs?=
 =?us-ascii?Q?6q9iCBvi0tg7k8r9HZRVbJL4HmuD/Q0MxPZwKvIl0xTGL7PxJP1FhT5kmugd?=
 =?us-ascii?Q?MJJG8qOPKfBVQt3Ba1tiuExhtJEpasw2+cC84OJNsFi/aVqYAWA2SBGYVInn?=
 =?us-ascii?Q?YAA6BtW+9ZjQeD9ttRZvjrnfD17xN9vx1GXm+yoKVXo5DrnMePt7q2dpVVJR?=
 =?us-ascii?Q?gMBbj8PsRlUgym9bbcNaJJLHtuAcsP258yUAglbmGPJ0gV9N7SRqLK2QSCrl?=
 =?us-ascii?Q?21taosRt5Sc2GQuUsMju3ntcyDspN8AQfz4Zs3aTZp27ojTWQdhs9FqIrC8k?=
 =?us-ascii?Q?cEvsMugxV5Fsirv2mWzyZg70FhxbVbDgFWiuOadNofYKLSgGyGqVjdd50fUf?=
 =?us-ascii?Q?X4JlZkuzaI01eCxAKydeQBvYhy+NA8H9v9S5hhP8wOSxL7FJPFhCzTKGiYmK?=
 =?us-ascii?Q?6AEcEK04EgCxOHoW76hOdeCau9eZ1kUgytsGRwa5VtNFstg6vXe3c/dVGTYO?=
 =?us-ascii?Q?ZpUNp+yUDqR67bRFepf42Es=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd8070c-c45f-4956-56e8-08dd9a87c9b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2025 05:56:55.1272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VzaeQfjeTRIqWZcb49E3DxISkE+sqbk3EVUhsppH3K5IQliBwbW/8oHjfA5j97C9nzPtatNlqYRfR5vdZu3G6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727

Hi,

I am running a basic test of block device driver unbind, bind while the fio=
 is running random write IOs with direct=3D0.
The test hits the WARN_ON assert on:

void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
{
        int bsize =3D i_blocksize(inode);
        loff_t rounded_from;
        struct folio *folio;

        WARN_ON(to > inode->i_size);

This is because when the block device is removed during driver unbind, the =
driver flow is,

del_gendisk()
    __blk_mark_disk_dead()
            set_capacity((disk, 0);
                bdev_set_nr_sectors()
                    i_size_write() -> This will set the inode's isize to 0,=
 while the page cache is yet to be flushed.

Below is the kernel call trace.

Can someone help to identify, where should be the fix?
Should block layer to not set the capacity to 0?
Or page catch to overcome this dynamic changing of the size?
Or?

WARNING: CPU: 58 PID: 9712 at mm/truncate.c:819 pagecache_isize_extended+0x=
186/0x2b0
Modules linked in: virtio_blk xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_RE=
JECT nf_reject_ipv4 xt_set ip_set xt_tcpudp xt_addrtype nft_compat xfrm_use=
r xfrm_algo nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4=
 nf_tables nfnetlink nfsv3 rpcsec_gss_krb5 nfsv4 nfs netfs nvme_fabrics nvm=
e_core cuse overlay bridge stp llc binfmt_misc intel_rapl_msr intel_rapl_co=
mmon intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_edac=
_common nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel ipmi_=
ssif kvm dell_pc dell_smbios platform_profile dcdbas rapl intel_cstate dell=
_wmi_descriptor wmi_bmof mei_me mei intel_pch_thermal ipmi_si acpi_power_me=
ter acpi_ipmi nfsd sch_fq_codel auth_rpcgss nfs_acl ipmi_devintf ipmi_msgha=
ndler lockd grace dm_multipath msr scsi_dh_rdac scsi_dh_emc scsi_dh_alua pa=
rport_pc sunrpc ppdev lp parport efi_pstore ip_tables x_tables autofs4 raid=
10 raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx r=
aid6_pq raid1 raid0 linear mlx5_core mgag200
 i2c_algo_bit drm_client_lib drm_shmem_helper drm_kms_helper mlxfw ghash_cl=
mulni_intel psample sha512_ssse3 drm sha256_ssse3 i2c_i801 tls sha1_ssse3 a=
hci i2c_mux megaraid_sas tg3 pci_hyperv_intf i2c_smbus lpc_ich libahci wmi =
aesni_intel crypto_simd cryptd
CPU: 58 UID: 0 PID: 9712 Comm: fio Not tainted 6.15.0-rc7-vblk+ #21 PREEMPT=
(voluntary)=20
Hardware name: Dell Inc. PowerEdge R740/0DY2X0, BIOS 2.11.2 004/21/2021
RIP: 0010:pagecache_isize_extended+0x186/0x2b0
Code: 04 00 00 00 e8 2b bc 1f 00 f0 41 ff 4c 24 34 75 08 4c 89 e7 e8 ab bd =
ff ff 48 83 c4 08 5b 41 5c 41 5d 41 5e 5d c3 cc cc cc cc <0f> 0b e9 04 ff f=
f ff 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 20
RSP: 0018:ffff88819a16f428 EFLAGS: 00010287
RAX: dffffc0000000000 RBX: ffff88908380c738 RCX: 000000000000000c
RDX: 1ffff112107018f1 RSI: 000000002e47f000 RDI: ffff88908380c788
RBP: ffff88819a16f450 R08: 0000000000000001 R09: fffff94008933c86
R10: 000000002e47f000 R11: 0000000000000000 R12: 0000000000001000
R13: 0000000033956000 R14: 000000002e47f000 R15: ffff88819a16f690
FS:  00007f1be37fe640(0000) GS:ffff889069680000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1c05205018 CR3: 000000115d00d001 CR4: 00000000007726f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 iomap_file_buffered_write+0x763/0xa90
 ? aa_file_perm+0x37e/0xd40
 ? __pfx_iomap_file_buffered_write+0x10/0x10
 ? __kasan_check_read+0x15/0x20
 ? __pfx_down_read+0x10/0x10
 ? __kasan_check_read+0x15/0x20
 ? inode_needs_update_time.part.0+0x15c/0x1e0
 blkdev_write_iter+0x628/0xc90
 aio_write+0x2f9/0x6e0
 ? io_submit_one+0xc98/0x1c20
 ? __pfx_aio_write+0x10/0x10
 ? kasan_save_stack+0x40/0x60
 ? kasan_save_stack+0x2c/0x60
 ? kasan_save_track+0x18/0x40
 ? kasan_save_free_info+0x3f/0x60
 ? kasan_save_track+0x18/0x40
 ? kasan_save_alloc_info+0x3c/0x50
 ? __kasan_slab_alloc+0x91/0xa0
 ? fget+0x17c/0x250
 io_submit_one+0xb9c/0x1c20
 ? io_submit_one+0xb9c/0x1c20
 ? __pfx_aio_write+0x10/0x10
 ? __pfx_io_submit_one+0x10/0x10
 ? __kasan_check_write+0x18/0x20
 ? _raw_spin_lock_irqsave+0x96/0xf0
 ? __kasan_check_write+0x18/0x20
 __x64_sys_io_submit+0x14e/0x390
 ? __pfx___x64_sys_io_submit+0x10/0x10
 ? aio_read_events+0x489/0x800
 ? read_events+0xc1/0x2f0
 x64_sys_call+0x20ad/0x2150
 do_syscall_64+0x6f/0x120
 ? __pfx_read_events+0x10/0x10
 ? __x64_sys_io_submit+0x1c6/0x390
 ? __x64_sys_io_submit+0x1c6/0x390
 ? __pfx___x64_sys_io_submit+0x10/0x10
 ? __x64_sys_io_getevents+0x14c/0x2a0
 ? __kasan_check_read+0x15/0x20
 ? do_io_getevents+0xfa/0x220
 ? __x64_sys_io_getevents+0x14c/0x2a0
 ? __pfx___x64_sys_io_getevents+0x10/0x10
 ? fpregs_assert_state_consistent+0x25/0xb0
 ? __kasan_check_read+0x15/0x20
 ? fpregs_assert_state_consistent+0x25/0xb0
 ? syscall_exit_to_user_mode+0x5e/0x1d0
 ? do_syscall_64+0x7b/0x120
 ? __x64_sys_io_getevents+0x14c/0x2a0
 ? __pfx___x64_sys_io_getevents+0x10/0x10
 ? __kasan_check_read+0x15/0x20
 ? fpregs_assert_state_consistent+0x25/0xb0
 ? syscall_exit_to_user_mode+0x5e/0x1d0
 ? do_syscall_64+0x7b/0x120
 ? syscall_exit_to_user_mode+0x5e/0x1d0
 ? do_syscall_64+0x7b/0x120
 ? syscall_exit_to_user_mode+0x5e/0x1d0
 ? clear_bhb_loop+0x40/0x90
 ? clear_bhb_loop+0x40/0x90
 ? clear_bhb_loop+0x40/0x90
 ? clear_bhb_loop+0x40/0x90
 ? clear_bhb_loop+0x40/0x90
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f1c0431e88d
Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
RSP: 002b:00007f1be37f9628 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f1be37fc7a8 RCX: 00007f1c0431e88d
RDX: 00007f1bd40032e8 RSI: 0000000000000001 RDI: 00007f1bfa545000
RBP: 00007f1bfa545000 R08: 00007f1af0512010 R09: 0000000000000718
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f1bd40032e8 R15: 00007f1bd4000b70
 </TASK>
---[ end trace 0000000000000000 ]---

fio: attempt to access beyond end of device
vda: rw=3D2049, sector=3D0, nr_sectors =3D 8 limit=3D0
Buffer I/O error on dev vda, logical block 0, lost async page write



