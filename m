Return-Path: <linux-fsdevel+bounces-37774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4172A9F7323
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 04:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4E416D1B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 03:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFF013A257;
	Thu, 19 Dec 2024 03:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HZ8snooy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0557D82890;
	Thu, 19 Dec 2024 03:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734577433; cv=fail; b=tRkgAEp58+dYn2PC4FpuHmcyE7G7O0lE5J3J7O2OlrRw1dsOE9zbnTGdgrquNi37y1zI+WzHjb/QMs8JK7DcKjMOp/FSN2zX8TjKmaeINyQqwdSh1NTTlniIMM0ySCdYH9YevQwFREPF05FlKGQLBR7gw7kxShdOnrbGetnnDhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734577433; c=relaxed/simple;
	bh=ueLoiJaAl7AGmEssPMFDc4fYBollDmcBhJ/9sIYbjDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pjytt6ZIH83AGUXDcAQVF/09mXPTVCl6HOp/xVjGmzrPxuz4o9DsmShMkDiG74qEZ4bFpSrG5DijaAn3dFDVhIzexvQqz/epBFI84yNqrQHRXBgjgkG6q/K0X5AlCkHTnX1wRMgF2NCgP+lsgyC6aa6WTLI0JhdyOtw1uF+RT3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HZ8snooy; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BILp9Fm024158;
	Wed, 18 Dec 2024 19:03:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=ueLoiJaAl7AGmEssPMFDc4fYBollDmcBhJ/9sIYbjDQ=; b=
	HZ8snooyUI9DOd5wIWi0vmE6mYtyPzECiS0WxWa6Cb761cIJazPQxnwrLaJSFSIC
	Sg2LwUWbRpgqcNRu8wQAkSHvTmBy/otrYG8QNjqt4inoXyb+t8oZpJ0zirXbkV92
	XTOEcd37bEgVAX/yf4ILynUZ6Q7tlsA1+Vt3GmtAV7givYRJMGmyKPDKETswPJr4
	bCpMuSKuLB9alv+VRSLbjNszs4vlVUrN9cZofu/4WIENiST7NebDZUNb1cp0UURs
	CTevoctAAavizc+2M6LOwsCVtOouV8b8OOkTyBtZ+qoKupGpw9VvI/gBDhZ0O4k6
	Rk/PZMzw9pbgiY8N0Ohi7Q==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43m3r5aygr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 19:03:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaU5k7yIc5RP0Z82U59Bf9t+iecpP8KHgEcYNzzJkPsnjD5hcgoJukZJsdgLF3Wr6b2sdB7XiQfPAsmofa7EbJOGMGLeI5rfCZlxrudz7RDc1tlA19mR+Wm2xoIquZTGKnhY79+Xjdz8vlPcoyQJ15uUAXwsr0G1f9rarVx7EzuEP1X2BPHPF2+0nE4GajXbe/Hnqyh1kyE8ocy+3rSeXYF4S9cfy7Q1TpTbfpoIsEytbwlEwSKrDGtv3QGDKJjx/Znct8M0Nfxxwnvqn6r+KrY1f6KoDzIn8JDxlDT8x61Edx5xzzGnaCso5J7DMnyFp/eBMq01vStCu6lxep4+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueLoiJaAl7AGmEssPMFDc4fYBollDmcBhJ/9sIYbjDQ=;
 b=ye1AYE65/jwp1DGIi61ALxOS4+KKoAF6iaT3HQoCQTPfepPbkx+mOdS4JCiVJTO11b8+MkOLEmihfKmtVnG96PSXHMb/RfuOWIrhdZjCxUCcpiTkS3J8n1ENt5R5Xo0yYjqxgY05Yw6CY5F/6GJq9P1IDlSfhQw4Kaj3KWtKHg5vvfoVVlEIa9n9HEDYFAkHcDRMx4iuC523AuawnogkwwU/okSHzG8BK1N1TgL0Juu7BwL+NxZNmHnmJIJiAAXBQGG0SNiwr30SMXdbFHhWzB/LtUBxKD4AHiJVudM+OSjNvBa/IO4cbSRZclLrDUbIzmCgeY3rySbTlOXMTQzguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by IA1PR15MB5919.namprd15.prod.outlook.com (2603:10b6:208:3fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Thu, 19 Dec
 2024 03:03:46 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 03:03:46 +0000
From: Song Liu <songliubraving@meta.com>
To: Dave Chinner <david@fromorbit.com>
CC: Song Liu <song@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "willy@infradead.org"
	<willy@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, Chris Mason
	<clm@meta.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "dsterba@suse.com"
	<dsterba@suse.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz"
	<jack@suse.cz>, "cem@kernel.org" <cem@kernel.org>,
        "djwong@kernel.org"
	<djwong@kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "fdmanana@suse.com" <fdmanana@suse.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        Kernel Team
	<kernel-team@meta.com>
Subject: Re: [RFC v2] lsm: fs: Use inode_free_callback to free i_security in
 RCU callback
Thread-Topic: [RFC v2] lsm: fs: Use inode_free_callback to free i_security in
 RCU callback
Thread-Index: AQHbUZIkuMkgETPge0K49RlO7IuMuLLszLWAgAAVVoA=
Date: Thu, 19 Dec 2024 03:03:46 +0000
Message-ID: <EEEFDE10-07B5-47B5-BE6E-DAC2FE2B7576@fb.com>
References: <20241218211615.506095-1-song@kernel.org>
 <Z2N7Ibxnmm-KEvea@dread.disaster.area>
In-Reply-To: <Z2N7Ibxnmm-KEvea@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|IA1PR15MB5919:EE_
x-ms-office365-filtering-correlation-id: 64ffc3d8-b5c3-4a6e-3680-08dd1fd9c125
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z29veElLS2owQU4vWkZaRWhBQTFEUTMyd3BqdmsvL0t4VzNNQm1jUDNsZ2k2?=
 =?utf-8?B?WUxJWE5ZbTJHT0pJeGY4NzdJK1hsWG9PTjBWMytab0hxcyt5R0FMaVRmUk5Q?=
 =?utf-8?B?QnlMdk4zN1FoTlNjUVlDdUxqbk0wVWJlbjkxRlBrM3B0eXNpTlYxS1FlSlBV?=
 =?utf-8?B?bkRublZnS1ZObFRyRjZZSHd2czNBYmJzSWJNVTgwN1hoVGhNbG4vZENOMldv?=
 =?utf-8?B?NlI5QkwzNXhZZGtjZFVudXI0NHpPWjRGWm03QjNWcWtBbzRTb2FFejB2cFls?=
 =?utf-8?B?RHZBbk80NG1jdkpDUU9qU3o2cnZCTExpdUsyNHVJY3ZNNnNqKzMvdTU4dVlw?=
 =?utf-8?B?MHh5dC9hZFdQVWY5OGtLLzIvMmlDY1pvMWZZeHFZUVhlVlgrdENXa3FZWUd2?=
 =?utf-8?B?dDVadXQ1WXhFa01Bc1FFUThFR0NMVU83c2REakJEVkxaSkJvbTRXaFB1TU0r?=
 =?utf-8?B?eEZvdFVhR2pXNjNDZkgzanpzS29oN3kwZGtHTXhPZzNqWFN1ZFcwNlVjMUJj?=
 =?utf-8?B?R2Z0STR6VWlsOFJ5ODJjYStvNGd6VUx5WEVqSDZzbWZkRW5MdFU3SkpkQzY3?=
 =?utf-8?B?NkdiZUUwODlTem1TbEwvMEFMb0VJT3F1eWxJa2JBeE1yN1hrU2FBWGJIeG1Y?=
 =?utf-8?B?WnphNlAyZEJ3b0w3NGc2TmpWT3pQdUkyM2hTZG9uUDZ0RTV0NFhyVmJYUGJv?=
 =?utf-8?B?Q3NWQXBVYys4WUhUWjVHbkZpSk1veGFJdGJDWTNCZVZyQm5yRGI4YVlVZUpW?=
 =?utf-8?B?WFlxd2F4ZCswYjhVcDNGVFhSZzJCejV1NWw3S3FoRzUrM05yaFhaZ3VNNTBX?=
 =?utf-8?B?Vk00Ym45Q3dyWXVTT016Z25wbWxDZmdWM2RZSGgzNS9zNkJqOFdOTDByenZl?=
 =?utf-8?B?eDJEODlnWjZ3VW80MkE3OEFaRjRkZjMwZFltMmY1SE9rY0dtU2JBaS9GbkV3?=
 =?utf-8?B?dy8xdi9mYVFxYXZJUmtxOVlLVi93c3ZYREdBb1d2RXZYQ3BkRFJVdWpnL1VQ?=
 =?utf-8?B?Wlpic2tkb0syeTBkcWJaTGhZclpLVlVWSGRXZG9vR0R1QmZUMTBjOUdyUk5T?=
 =?utf-8?B?dkVSeS9LRG5tUU53RTZSSmZnNFB1RERoWmlvSGNnOGxrZmxOZ21RTWxIdERY?=
 =?utf-8?B?eGVQekVibzBBVG5VNk0ybjJmeUNaZkFNYTBrQ0hqOEZYVGlhZlk4TGV5bUZr?=
 =?utf-8?B?SlQ2WGpPVjFleVpYd1hIeGlRNENTR1p5WjcrSlNtWTVTVTB5Z2RiMHRzZHcx?=
 =?utf-8?B?YWRDUmFEODZOb2NsRUFpSHFXMEUyMTlVeGVFTjRHYVZhRzJQczZjbGJFam1n?=
 =?utf-8?B?Y093dXRiWVlzV3gvNTlGeTg0MVZvZk9ZNXltT1MwU0N1VGYwLzFxWFBPNWRx?=
 =?utf-8?B?L3FSTXNOZWQ4c0d1bkxCU2h2OEVodUhkQmdxd3ZqSjV1UGJGRGU2ZnBPQUVu?=
 =?utf-8?B?TlJacWpTeS92NjNGeGxWcHdyRVdZdDRnZy9rNHMrUFBJdkdZSDlqV1MyZmxN?=
 =?utf-8?B?dHEwYUkxZU5QK01Tc0VpZ2Z3ZHZ1RjNGd1FpWXVGOVloT3JQOVVvUGpoVExQ?=
 =?utf-8?B?YVVCdjVHdGkwckErdEh1SVh0RldiWURwZkFJMzVaOGc3bUFUSzU0L01zbXFo?=
 =?utf-8?B?MWFCQ3dLcXA4MlV0eExqdllneXhYVVlvSmNRbGMzemd1bTV3blZaa2YzN2s1?=
 =?utf-8?B?TGRDNER2R2RMaElzMG95TVljdHNOUmJZTmZ2RElFZXlKd3NhWnFkb21Gdmp5?=
 =?utf-8?B?bXVuSUpTazBWVmFUOWlDYVhGRXNFcitZemVBVFhZU3BxazYreFhnUjlsVlFF?=
 =?utf-8?B?U2NrbkY2TTl2ZDJJeGt5Yi9RdHdFT2xObXRBeGpzL294R1hJYm9wbTJyMUZk?=
 =?utf-8?B?WjczUzdFaGRmWEM5SXd1cHFLaENEamdTb2hWU3g0SkZyTXpjbVpRcXZBcWJn?=
 =?utf-8?Q?Ql44MnkqW+M53dODqgjLtsPG0kl3CclJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2hjWGtEczErZDY3MzUzQVNHQ1MxNzRUWUhmRUJmQ1M5YUJyUUUzQkVIazZN?=
 =?utf-8?B?N2NCRDFZSWRob3BNeE5kdmV6QzROSTFuOTVQcDBtc3lJSlNPcW5sNy9yWFh5?=
 =?utf-8?B?anl0WHFjLzF3NnNqbmxTRWd3VDJmRXduejFuYnU0dWEwRUE1SllZeC9Gcmp4?=
 =?utf-8?B?WXdWaE1JZWh2YVIvYnl1d0s4RzBjSEdDSys0R2NhTS9pZTBzMnZCZWxUWkNT?=
 =?utf-8?B?eDU1WlJWSzcwU25Eem52Zlh0MHVRbnFUYVRpbU9OdGppbWJpSytiZm0vRFdF?=
 =?utf-8?B?OXF6Y2F2WFZaZytEYVhiRGU4MjlnalRnMmxOZEluVVpHdzkxczNYY0FBMUo3?=
 =?utf-8?B?dzYxSkpEdU9XaGkrUzBZSHQ5NS9nTnBRaFc2VEpPNEEyWno1NnJLWXhYakRm?=
 =?utf-8?B?UDRHRFJFZmJVdElhNk82Q2wzdXowZGhSRlhxZXVYRXBYMFZIMWF5a3lzcHRI?=
 =?utf-8?B?WlhzUHFxREdyUzZjMXk2WE84NjRXYk53Z1JvckZxM3F5K1lmVUNiektLaGJi?=
 =?utf-8?B?UERKbjczTVF0eUtFY2UzM3IrbmdxbjZXWTd2REFFdHlIeDJ2cGZLQlVFY1ZJ?=
 =?utf-8?B?SnZsWThCT21IcWlxVGt0dlRmc3lLbTkvNFZidVRVWmNQbmhzbVgvcmxGKzBJ?=
 =?utf-8?B?QUEzNVBCRGpUZVpoQ0pSMDlITmhJbGlkVDVPTG51SklyN0FGeEpIbmtSWi9D?=
 =?utf-8?B?NlJnMVFITDUyVE9zcVN4blhpT3ZnNklZMVQrSzdBVTNWOURXWnVCV1QzUFNv?=
 =?utf-8?B?eFlGY3IxbEUzYVhPcXZsZm5aODNQbHNGdFZVcC92RnhnVkxOM09mZnc2ME9Q?=
 =?utf-8?B?Q1MrYjJOZ2hGWWsrMXZYcjlRNDM3TXVsY1UvQ09iNzBnUnhOTFZ2aHNCYTBE?=
 =?utf-8?B?TzRyZHRRbUZRaWFJN3N2OFYya3BoYTFsb2JaYVM4ZUtMYlU3Sjd6U2FaMlIx?=
 =?utf-8?B?dnE2Uk55d2NkZ3BlakV0VUhEdHIzTzBtNTB2QXhMY2xiQ1AvV3BLWU4vd09L?=
 =?utf-8?B?cU5lT1BwcTRWNkhpYmc1bjJadFF6UmlZQjc4RGxFekxmNmdrbXB0eVozN0wx?=
 =?utf-8?B?amZ0Q3haZUduM1htQzJHOCt3aVZrSGhSZ1RpMmpETTV1a1BmOEdZSWdsVitt?=
 =?utf-8?B?VG4vdEVoTG12bnF5TWZYMWxZaFJaLzVEa0RscnRoR0JFb0d4WXVXaFhIMWpK?=
 =?utf-8?B?WXh3VjdmZUxDclkvKy83Skw2VTFJdXpFbXhYTlQ4M3RyWFB5Y3VIR21VbzAy?=
 =?utf-8?B?YjNWbXc4MndHRnEwSlRFSml1bUZGTGQ1bFBkRnVqalVSNkt5VGtiQzM5RWxE?=
 =?utf-8?B?V01KWjJ6ZS9nOHI5TW5GL3VUNnVPaWh1di9sWVdBTnI0eEpRZzQxZmc3MCtm?=
 =?utf-8?B?bEFRWUl3NkRTelhWc0ZCdE5vcHY1WHlkQnlDcWxyZTJPdi9hM21FVFcwaFo1?=
 =?utf-8?B?cVBxRW1ycW5UTjFuZlVLMjB1WGN3M2Z1VVJIdUpNbVlqUmFZYW9CdUtPQUZp?=
 =?utf-8?B?UkNhV25tTGIvNjFvQUVaKzZxNVJHT2RmUExvQ3ExOTQ3cVJhUUp4ZFFJV29w?=
 =?utf-8?B?RUlyU1pPdTRWbEtWYmx2VHFqbHdBVnlvRDBJMklYYzRSRy9KWUg0cHZsdnp6?=
 =?utf-8?B?NmkxNGNvVDUyaHY0R0l6RnQ0d1ZLeFgremxTTnhEWnRJMllZYUxVbHVKMkpK?=
 =?utf-8?B?Z0tuK1hsSXJBK3dYUXEyVkxoTzBVWW1PT1hacVVFYlNQYTlSTjFEazU0UlJE?=
 =?utf-8?B?dkxDL05oUTJodlV0dWQvejZhU3BhcExpdEtzU3o4eUVVMVM1Ly9PcC9RZUw1?=
 =?utf-8?B?ZXM1TUhlS01COStuWitIOTY2SHl1d3pCUnlTMDBlN2JyQisrRjhHK2daQXZh?=
 =?utf-8?B?MGRtdDc1U1pEYitTNTZLZTV4VGM0UmcwODd2S2RuUUZQMWk3ZWZLanFQald4?=
 =?utf-8?B?enFOY1VHN0gxOU5PV2dudUR2QjNzVHZCeFRsdWVtTk1sbElxaC8ydVRaVFhl?=
 =?utf-8?B?SVNoWVZUbDZFcXRGVGoxcFN5ejhSNU50VHVoRXMxb2RNWUFKNXM2NDZ4Z3V0?=
 =?utf-8?B?dGtmZ1grTE9PTjFJRnRMU0ZWMGZTbzV3UFc2MDVLVGFvdi9xckxDMHZtZytj?=
 =?utf-8?B?M1RGZEFIc3pHOGdWNHpHYTQ4U3YzZnlHU0JxcFE3dktaQXhNd0Jick1oM3Z5?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C9E367C53206B418BDD815F88373C5D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ffc3d8-b5c3-4a6e-3680-08dd1fd9c125
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 03:03:46.4767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EePKMdpxx0hGyU/Vcop6k5rj77YnWsWvE+s4OKUMUb4xEwwiqXDJfgj5k/11xzqL3O1CDYYalpOD7HBE7+MCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5919
X-Proofpoint-GUID: TKkCPQynowrA2ZR-fGOhcQ44o3Az-ovx
X-Proofpoint-ORIG-GUID: TKkCPQynowrA2ZR-fGOhcQ44o3Az-ovx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

SGkgRGF2ZSwgDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cyENCg0KPiBPbiBEZWMgMTgsIDIw
MjQsIGF0IDU6NDfigK9QTSwgRGF2ZSBDaGlubmVyIDxkYXZpZEBmcm9tb3JiaXQuY29tPiB3cm90
ZToNCj4gDQo+IE9uIFdlZCwgRGVjIDE4LCAyMDI0IGF0IDAxOjE2OjE1UE0gLTA4MDAsIFNvbmcg
TGl1IHdyb3RlOg0KPj4gaW5vZGUtPmlfc2VjdXJpdHkgbmVlZGVzIHRvIGJlIGZyZWVkIGZyb20g
UkNVIGNhbGxiYWNrLiBBIHJjdV9oZWFkIHdhcw0KPj4gYWRkZWQgdG8gaV9zZWN1cml0eSB0byBj
YWxsIHRoZSBSQ1UgY2FsbGJhY2suIEhvd2V2ZXIsIHNpbmNlIHN0cnVjdCBpbm9kZQ0KPj4gYWxy
ZWFkeSBoYXMgaV9yY3UsIHRoZSBleHRyYSByY3VfaGVhZCBpcyB3YXN0ZWZ1bC4gU3BlY2lmaWNh
bGx5LCB3aGVuIGFueQ0KPj4gTFNNIHVzZXMgaV9zZWN1cml0eSwgYSByY3VfaGVhZCAodHdvIHBv
aW50ZXJzKSBpcyBhbGxvY2F0ZWQgZm9yIGVhY2gNCj4+IGlub2RlLg0KPj4gDQo+PiBSZW5hbWUg
aV9jYWxsYmFjayB0byBpbm9kZV9mcmVlX2NhbGxiYWNrIGFuZCBjYWxsIHNlY3VyaXR5X2lub2Rl
X2ZyZWVfcmN1DQo+PiBmcm9tIGl0IHRvIGZyZWUgaV9zZWN1cml0eSBzbyB0aGF0IGEgcmN1X2hl
YWQgaXMgc2F2ZWQgZm9yIGVhY2ggaW5vZGUuDQo+PiBTcGVjaWFsIGNhcmUgYXJlIG5lZWRlZCBm
b3IgZmlsZSBzeXN0ZW1zIHRoYXQgcHJvdmlkZSBhIGRlc3Ryb3lfaW5vZGUoKQ0KPj4gY2FsbGJh
Y2ssIGJ1dCBub3QgYSBmcmVlX2lub2RlKCkgY2FsbGJhY2suIFNwZWNpZmljYWxseSwgdGhlIGZv
bGxvd2luZw0KPj4gbG9naWMgYXJlIGFkZGVkIHRvIGhhbmRsZSBzdWNoIGNhc2VzOg0KPj4gDQo+
PiAtIFhGUyByZWN5Y2xlcyBpbm9kZSBhZnRlciBkZXN0cm95X2lub2RlLiBUaGUgaW5vZGVzIGFy
ZSBmcmVlZCBmcm9tDQo+PiAgIHJlY3ljbGUgbG9naWMuIExldCB4ZnNfaW5vZGVfZnJlZV9jYWxs
YmFjaygpIGNhbGwgaW5vZGVfZnJlZV9jYWxsYmFjay4NCj4gDQo+IE5BQ0suIFRoYXQncyBhIG1h
c3NpdmUgbGF5ZXJpbmcgdmlvbGF0aW9uLg0KPiANCj4gTFNNcyBhcmUgVkZTIGxheWVyIGZ1bmN0
aW9uYWxpdHkuIFRoZXkgKm11c3QqIGJlIHJlbW92ZWQgZnJvbSB0aGUNCj4gVkZTIGlub2RlIGJl
Zm9yZSAtPmRlc3Ryb3lfaW5vZGUoKSBpcyBjYWxsZWQuIElmIGEgZmlsZXN5c3RlbQ0KPiBzdXBw
bGllcyAtPmRlc3Ryb3lfaW5vZGUoKSwgdGhlbiBpdCAtb3ducy0gdGhlIGlub2RlIGV4Y2x1c2l2
ZWx5DQo+IGZyb20gdGhhdCBwb2ludCBvbndhcmRzLiBBbGwgVkZTIGFuZCAzcmQgcGFydHkgc3R1
ZmYgaGFuZ2luZyBvZmYgdGhlDQo+IGlub2RlIG11c3QgYmUgcmVtb3ZlZCBmcm9tIHRoZSBpbm9k
ZSBiZWZvcmUgLT5kZXN0cm95X2lub2RlKCkgaXMNCj4gY2FsbGVkLg0KDQpUbyBiZSBob25lc3Qs
IEkgYW0gbm90IHN1cmUgdGhpcyBydWxlIGlzIHRydWUuIE1vc3QgZmlsZXN5c3RlbXMgDQpwcm92
aWRlIGEgZnJlZV9pbm9kZSgpIGNhbGxiYWNrOg0KDQokIGdyZXAgIlwuZnJlZV9pbm9kZS4qPSIg
ZnMvKi8qLmMgfCB3Yw0KICAgICA1NCAgICAgMjIxICAgIDI4MDgNCg0KRm9yIGFsbCB0aGVzZSBj
YXNlcywgVkZTIGxheWVyIGlzIHN0aWxsIGluIGNoYXJnZSBvZiBmcmVlaW5nIHRoZQ0KaW5vZGUg
YWZ0ZXIgYSBSQ1UgZ3JhY2UgcGVyaW9kLiBGcm9tIHZmcy5yc3Q6DQoNCmBgZnJlZV9pbm9kZWBg
DQogICAgICAgIHRoaXMgbWV0aG9kIGlzIGNhbGxlZCBmcm9tIFJDVSBjYWxsYmFjay4gSWYgeW91
IHVzZSBjYWxsX3JjdSgpDQogICAgICAgIGluIC0+ZGVzdHJveV9pbm9kZSB0byBmcmVlICdzdHJ1
Y3QgaW5vZGUnIG1lbW9yeSwgdGhlbiBpdCdzDQogICAgICAgIGJldHRlciB0byByZWxlYXNlIG1l
bW9yeSBpbiB0aGlzIG1ldGhvZC4NCg0KPiBUaGVtJ3MgdGhlIHJ1bGVzLCBhbmQgaGFja2luZyBh
cm91bmQgTFNNIG9iamVjdCBhbGxvY2F0aW9uL2ZyZWVpbmcNCj4gdG8gdHJ5IHRvIGhhbmRsZSBo
b3cgZmlsZXN5c3RlbXMgbWFuYWdlIGlub2RlcyAtdW5kZXJuZWF0aC0gdGhlIFZGUw0KPiBpcyBq
dXN0IGFza2luZyBmb3IgcHJvYmxlbXMuIExTTSBvYmplY3QgbWFuYWdlbWVudCBuZWVkcyB0byBi
ZQ0KPiBoYW5kbGVkIGVudGlyZWx5IGJ5IHRoZSBnZW5lcmljIExTTSBWRlMgaG9va3MsIG5vdCB0
aWdodGx5IGNvdXBsZWQNCj4gdG8gVkZTIGFuZC9vciBsb3cgbGV2ZWwgZmlsZXN5c3RlbSBpbm9k
ZSBsaWZlY3ljbGUgbWFuYWdlbWVudC4NCg0KVW5mb3J0dW5hdGVseSwgbWFueSBmaWxlc3lzdGVt
cyBhbHJlYWR5IGNhbGwgdmFyaW91cyBzZWN1cml0eV8qIA0KaG9va3MgZGlyZWN0bHk6DQoNCiQg
Z3JlcCAiaW5jbHVkZSA8bGludXgvc2VjdXJpdHkuaD4iIGZzLyovKi5jIC1ySSB8IHdjDQogICAg
IDQ2ICAgICAgOTIgICAgMjE0NA0KKDQ2IGZpbGVzIGluIHZhcmlvdXMgZmlsZXN5c3RlbXMgY2Fs
bCBpbnRvIHRoZSBzZWN1cml0eSBsYXllci4pDQoNClRoZXJlZm9yZSwgSSBkb24ndCBmZWVsIHRo
aXMgY2hhbmdlIGFsb25lIGlzIG1hc3NpdmUgbGF5ZXJpbmcgDQp2aW9sYXRpb24uIEluc3RlYWQs
IGl0IGlzIHByb2JhYmx5IG1ha2luZyBleGlzdGluZyBsYXllcmluZyANCnZpb2xhdGlvbiBhIGJp
dCB3b3JzZS4gSSBwZXJzb25hbGx5IHRoaW5rIGl0IGlzIG5vdCBtYWtpbmcNCnRoaW5ncyB0b28g
d29yc2UuIE9uIHRoZSBvdGhlciBoYW5kLCBzYXZpbmcgYSByY3VfaGVhZCBwZXIgDQppbm9kZSBp
cyBub24tdHJpdmlhbCBzYXZpbmdzLiANCg0KSXQgd29ydGggbm90ZSB0aGF0IG1hbnkgc3lzdGVt
cyBhbGxvY2F0ZSBtZW1vcnkgb24gaV9zZWN1cml0eSwgDQpldmVuIHRoZSB1c2VyIGlzIG5vdCB1
c2luZyBhbnkgTFNNLiBUaGlzIGlzIGJlY2F1c2Ugc29tZSBMU01zIA0KY2FuIG9ubHkgYmUgZGlz
YWJsZWQgYXQgY29tcGlsZSB0aW1lLiBEaXN0cm8ga2VybmVscyBhcmUgbW9yZSANCmxpa2VseSB0
byBlbmFibGUgdGhlbSB0byBmaXQgdmFyaW91cyB1c2VycycgbmVlZHMuIFRoZXJlZm9yZSwgDQp0
aGUgaV9zZWN1cml0eS0+cmN1X2hlYWQgInRheCIgaXMgbm90IHNvbWVib2R5IGVsc2UncyBwcm9i
bGVtLiANCldlIHByb2JhYmx5IGp1c3QgZG9uJ3Qga25vdyB3ZSBhcmUgcGF5aW5nIGl0LiANCg0K
VGhhdCBiZWluZyBzYWlkLCBJIGFtIG5vdCB0b28gYXR0YWNoZWQgdG8gdGhpcyBjaGFuZ2UuIElm
IGZvbGtzDQp0aGluayBhbGxvY2F0aW5nIGFuIGV4dHJhIHJjdV9oZWFkIHBlciBpbm9kZSBpcyB0
aGUgYmV0dGVyIA0KdHJhZGUtb2ZmLiBJIGFtIE9LIHdpdGggdGhhdCBhbnN3ZXIuIEkgcHV0ICJS
RkMiIHRoZXJlIGZvciANCmNvbW1lbnRzLiANCg0KSSBob3BlIHRoaXMgbWFrZXMgc2Vuc2UuIA0K
DQpUaGFua3MgYWdhaW4gZm9yIHlvdXIgY29tbWVudHMuIA0KDQpTb25nDQoNCg==

