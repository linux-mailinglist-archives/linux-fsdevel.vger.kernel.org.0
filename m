Return-Path: <linux-fsdevel+bounces-73481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE72D1AAA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E84C30164F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E32378D8F;
	Tue, 13 Jan 2026 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l50PDYQS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D127E07A;
	Tue, 13 Jan 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325817; cv=fail; b=Qz/K0Vy1iDMb2u2IaS7NBVu4P6oF7wjc6iWtTNn308eWTyBO6HVB7NPtQ6eEi8gYPeEIyt4L++BqF5VRefkJ4hYK4105mAMZ4ss5/KTS9j3y6Z9hm+5HipUBk0yLh7Kd+kxYt7d5Y0dWesUVffdoUh2Q1pyqA+g28PbDxxpUrGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325817; c=relaxed/simple;
	bh=nXroyCLzgZ2oqGMFw3CSkX6lzw0Zuf4CGWpdyBKJqaA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ma/ixE3Zxrub1DLH+omNZ6Nd77cWiCHzncn1yvQsgx39dExDLglEDkhVIDFR1Ph/jlVuaIWyKgUFc1Chn+Y7S/ATE24nd7/fTK/dAGBJ0aa95HFcfAkYVT+ObTu4qnKdcKhzB6fske9zvilkNxKhVQOtlfN6Azlw8SQxHxuRbHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l50PDYQS; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60DGVOIq009567;
	Tue, 13 Jan 2026 17:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=nXroyCLzgZ2oqGMFw3CSkX6lzw0Zuf4CGWpdyBKJqaA=; b=l50PDYQS
	6f3esb8RWA0cbcBsTCGH7FBj+FskMwRWwp+OtP75vyEscuSMozMwN9FVjJUS9frM
	l3gg3gqOzbp2wDBuQIAHQ6UygM5p9NKt30lipkf3T2ZDUSOvjAAaexcbi3C+yTud
	1AezjSKfFEHIYKVQpl/cHbV/RXEu+9Kd2PqG2ZDuGWdfy55FtX1fNVKhgPZlPImO
	fwyqxXg/uifARtwanyv4OPMUZHfdyt1GHrg/QXubwPGTgYYxLqDNE5o9FUXX/uDZ
	CafmGjIYSJDNzljxKWwFtCNmiGdSRruGxADiJ8a4XRg5bTf7+ZfXcT2des1uS9Lc
	mHwJYBc2qoqXnQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4dpxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 17:36:06 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60DHTIYv019128;
	Tue, 13 Jan 2026 17:36:05 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4dpxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 17:36:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHzUlr+icSUqU4Kbj61Wf4tMMx+KCI0Awcm8OVoFYV5515VIUFk5NVMxhLpL5uwGOpk3hRFSJhTdirtbQkwXzwHt6ZqkRfSyx9zdMuk2x07ti3Mdsi7tuxrib8rvZDEmZ/9Z8ed/IBiMb3x34+S2P8iCHZw8fAtwcT/cwimTxd2qzwePEiCAcwedL4+6DFbUYjSaOoFhp1wokPjOAR3cGyFsTqUpH5h2N82D60i9DZh2gkKtUaoJsdpv8wfpFxqQkktktISAqnjkMrXDAjESNMRBKPvMjNVoq3LqdIiMyi86156hil6VQcGNByFC9DLPJDAiZY3HvV9u1zGXaqUyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXroyCLzgZ2oqGMFw3CSkX6lzw0Zuf4CGWpdyBKJqaA=;
 b=RVnIiXTD0IhF75j6frPwPpaTNhLuni6sh2Xyp+3TSHakQiV3g9RoiNN3OxiqkUNHtKrEHLR7Tn45ANZY5Fpkafa69LiT6HHRIFvlVOlJdWGP4nGjoD9AD6qoX1NZn3jZPyazYvpiNsDa5XNjBD4bhrdRq1ah6xKqPW8Zo4MqiV2Slq78hHIJNudwlYW33XDda/wVK/uEQtVqn67qzHe97skU754CDLeVifdcSfHqnjejlZdn78Mpw+mxoR6E4ma8v0/CTylosAXoEmH2Y8hpvn/tDSCy4BZoeSHI3AguXWMAoBwBbfhXbW8IETk14hc7Q0Wjr3hStIUsbu0Zgi5zQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CHAPR15MB6976.namprd15.prod.outlook.com (2603:10b6:610:2f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 17:36:02 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 17:36:01 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "cel@kernel.org" <cel@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "vira@web.codeaurora.org"
	<vira@web.codeaurora.org>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "chao@kernel.org"
	<chao@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>,
        "pc@manguebit.org" <pc@manguebit.org>,
        "yuezhang.mo@sony.com" <yuezhang.mo@sony.com>,
        "almaz.alexandrovich@paragon-software.com"
	<almaz.alexandrovich@paragon-software.com>,
        "hirofumi@mail.parknet.co.jp"
	<hirofumi@mail.parknet.co.jp>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>,
        "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "trondmy@kernel.org"
	<trondmy@kernel.org>,
        "cem@kernel.org" <cem@kernel.org>,
        "ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>,
        "jaegeuk@kernel.org"
	<jaegeuk@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "sprasad@microsoft.com"
	<sprasad@microsoft.com>,
        "hansg@kernel.org" <hansg@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>
Thread-Topic: [EXTERNAL] [PATCH v3 06/16] hfsplus: Report case sensitivity in
 fileattr_get
Thread-Index: AQHcg/WWBphwXTZGWE6VqZjetSCNQ7VQXi4A
Date: Tue, 13 Jan 2026 17:36:01 +0000
Message-ID: <cd9402e9fd09580d8f1adcff2f4785fd482cf8ec.camel@ibm.com>
References: <20260112174629.3729358-1-cel@kernel.org>
	 <20260112174629.3729358-7-cel@kernel.org>
In-Reply-To: <20260112174629.3729358-7-cel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CHAPR15MB6976:EE_
x-ms-office365-filtering-correlation-id: 5f850588-c3bd-44e2-a235-08de52ca388d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2piKzhJVnVJNkR1cmdrMEVxZUZBL2hJZFp0L1NEaFpXaTdJMEdvNWM5YlVS?=
 =?utf-8?B?YllZaDkrNmRZdmcvams4eTRFM2E0RXhMSTFyckR2UWJzMEpFZ202a1ZEL3ZR?=
 =?utf-8?B?OUhTRGwvUG9yOTBNVC9XSmpPSkpVL0VwaXYzbXdNN1ppeGQvaG9EWWNESi9M?=
 =?utf-8?B?UFk4c0VEUDhMdlUrdE9weHVvYituMUFDMy9NNm10TEowcC9mb2EvUmZkYWdr?=
 =?utf-8?B?SHl4dUNpcXFxa05WZEQyZGtEWS9nQ2RPbkRYNUplTnRLVDZTbnd4T0NJMDZM?=
 =?utf-8?B?SjMzWmdKQzFEYTlGK3dvVFFjSmozclBOdkw2aGgybGE2bGFVZUd4dVBSRDRw?=
 =?utf-8?B?YmFkbWF2M2hacTczWU13VzNnbVdjcDE1V0txMjFocW9mM21CcmpNVGpJU1lC?=
 =?utf-8?B?aHdDTFVTV2l1aTNUQlpnQWRmRGtpQ201UG9kVXpBWU5SaGZscGo2czhEdjJG?=
 =?utf-8?B?REJ4akt4Y3RoUnBTNmNRNUJzeHJONzRNODhLeEV4UStaYjFOZGVHVUhjQlhv?=
 =?utf-8?B?RDAraFJyenJVVit3NSs5UEZ5Z2VVNCtsRzd6R0VwSi9XWVJwdEZtam9EOXc3?=
 =?utf-8?B?dGY4N0ZYNlRqaExHak04cENBQnJtVzJnbzZiRmJscDVrS01ydDFWUWw3QmVt?=
 =?utf-8?B?L2IxM1JndzY4a0pNWVFzZHQxZ1Qvc0Rub241U0ZvWDV1V0xnQlFBODgyMFA3?=
 =?utf-8?B?azRaY0RCSGFZSEJuRyt2aUhNRVpOOE9JQ2tTZVE0dWU3ejhva0JuU1Q2dm91?=
 =?utf-8?B?QjBVdzVRSmVZd2hIUXlOajZpVEhiSWxIckVmTU9Ocnd4OFBFNUgzQmJqUThV?=
 =?utf-8?B?eWs1R0VRNnFTMUZXNmdOV1d5akV3RDZlcERYMkNNdDRXdDVuR2YzTmxrVGhR?=
 =?utf-8?B?am1WY25iMTk1anlVbjY5cTNhb0pxWDFtSEZqelNmcXpEd0JhR2lLQjFzMFNY?=
 =?utf-8?B?bmc1RUVNZkhkenM2M2ZwQ0ZBWFEraTQxd091cDZrRDd0TTkxVlAxb3AvTGNx?=
 =?utf-8?B?dG9zSVJ1QVhkQTA0d2ZuN1paNGJLZzJkSkdBUUFRMGdYNDFNSzE1Y2NnVlVk?=
 =?utf-8?B?dzRldWlMeWF1REpiSjlQS3dBOWhteVJCVkdCQjVWOUg2bGJid0lYUGdhaE9M?=
 =?utf-8?B?ekJNaWtIV2ZvOXJEdG9qejFUQThDTUFhYkVlMlJ1Z3NUSDN2V1FMY2Y0Wnc1?=
 =?utf-8?B?eGJkekE3cSsrb0VZaHUrU1Z1bStjRFNwck40WGhCaGtoeWluNmVpVVlsQWd0?=
 =?utf-8?B?VWVCMTZnU2JYa01IK2J3c0RqSDMxdmF0NUR4dENpUmd5dUhkMDFmeFNrQllU?=
 =?utf-8?B?a3gvS2crWW8wK3RUV0JDVWZ1MkpZUEJNUjBmbWRPVzAyR1I4eTFlVXRxWC8z?=
 =?utf-8?B?b0psUFh1bk9IRnNUNnFTOFd6RGh6Y2kxL3hIWDVsOFlXSFFveFpPdjhwREdn?=
 =?utf-8?B?MVI4UEg4T1l2TWFhUjBLSFZubjU2ci84ZlNvZ2diQ2dIamUwa2VwYTI1WS95?=
 =?utf-8?B?K21rMEl1aWJxYkJlUGM2ZFQ1SWwxZmdINFNIdlJlV054UjY0QXJGY1NXcC9G?=
 =?utf-8?B?R3U1SUNvR1FZdGpsUVVuQ3dzWG90MTlGSWlmVk5VYUpuV2FFbG5JcWc1dkhs?=
 =?utf-8?B?K01VMm9vVktpQWJ3b1VEdG9QanI2OHdCVC9ncDNHalYvMnBMNHJJby9yOW9Z?=
 =?utf-8?B?V0hlQi9McDhXMC9JbDRKbElmMUFtRjZsYTNlR0RnUW8wN2FOQmdtUDdLNTNU?=
 =?utf-8?B?eUR0SXlkcWxjNmwrZm5wdnJVbHhham1xNXV6aG1xMkdkUUp4TGNYRkNSNjgx?=
 =?utf-8?B?VFpNZ2NqZWErZkszY1prV3ZYYnRQYmh5cU1Xc1ZzbjJQUmNKUmsvMjZVd2Er?=
 =?utf-8?B?eHNWaitISzRONDg0SWtsUjdYc0ZlOVltL0s3Qi9EK2VreFZaY2JLSTVZUGxF?=
 =?utf-8?B?a01pSjRkN1AxOTBqMkRhaVNqeDd4TlptcUhVTDJlRlB3SFZ2L21oVUhHa3NR?=
 =?utf-8?B?QVVsSzFUT3Y2NlpXQ0dPelRRZHZlR3Fnd2ZlN2lGRStaYVdUVHhCQXJmWDlW?=
 =?utf-8?Q?phmQ9o?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFYvZjhDNUJ0R3JlUjROdmtMdGRwSTFENmhYcTZveUlVQWhib2pkZTR1YkhR?=
 =?utf-8?B?WmJZRXhhS0VuZFNtaFVsWk5UUWhHcS95aDZQRmFJa3hwS0JZS1huUk5hdFZP?=
 =?utf-8?B?YVFzMVBXckJZSTBZOTIxRGJ0U3RJZjhnbUYvNmR1RXlwZnRDYmVWUDJVdlpy?=
 =?utf-8?B?RzMzMlQyTkYvaU5SZ2J6ek1EQTNjZEtReG5BdzNvVGZxa2JPNmhjWlNseE9U?=
 =?utf-8?B?TDJLeG95RUpKaE5SbHE4b3dTOHlIQ2JOMDRpTkVUeFp2aDVHMXk2aHROTXVi?=
 =?utf-8?B?dTYyMUhqNWptM3JFSVVtU1pqV1M5RGhuK0Ftd2xvZWJwRmtiejU3N1p4dUFR?=
 =?utf-8?B?NmhtdDhGN0R6RlFiUktMczl6RitwWk81d2dsQ3hJUnhXby96blUyVDR3RkNO?=
 =?utf-8?B?LytLQVhHZXI2RFdxRmVBQVdzaU9aRVlFb2FXaVhKaW5DYXUzZjFaMHNqajBX?=
 =?utf-8?B?V3ZIQ213Z0xUUDBUb1QrVmR5RVo4THpRempwOVFrS3I5MUNHN1hMRStnRnE0?=
 =?utf-8?B?eFJqUDd2TENsRm14K3RyQzdLWDdhbGZPbWlGWEhwd2loNTNETVRuNDlxM1Ns?=
 =?utf-8?B?R2M3RVg0a2hHVTVudlVBNXhuVVBLVDM3ZjJraDlETDUxQ1NKY2Zkd3NGN0R1?=
 =?utf-8?B?WkpwaFZQeHJJcXltMEdSNlBheXBBYUlTMzZHaEhmRjI5K0ZqMnhYWDhpVG1D?=
 =?utf-8?B?T3VXQmRmSTRvQTA2YjBaTm9MbDE4OVdwT2sya2t1TmhJWVJpRE9haDNsanVz?=
 =?utf-8?B?OWFCSi9YY1pjc3VYb1Awb3lrenp2VVllL1JqMzU5UjlUUEw2TGttTXc5YXdy?=
 =?utf-8?B?dHZESHB3TmdsVVRFZUNYYm5ueW1QdUx2TTdDNTNmdmt6MjBiVVpGOXl6ZUdV?=
 =?utf-8?B?MitWOG0yVHJZQWxuWW96czI0dVg3TzJyM0xLanluNnIxRkp6YkJWcWZ3S1RQ?=
 =?utf-8?B?T0IwcXg1NzdzbHQycTNWVm9YUUVpYUx4RDJsTkNGaVZEdUtUKzZOSGg2c3lo?=
 =?utf-8?B?ckc3bk9HMi9QeFZwcm5xSldkNGJ0T0U5QXI2amNEZDlYUkptQXFUL2J3NlVI?=
 =?utf-8?B?eitoQUxRdTVKdjljaGFsdUhMUXJ2WEYrVXdPVllmZkxNNEFBT3VXaVkycmFr?=
 =?utf-8?B?WkJvREl0YzM4eS9QRENTalBVVWZIYVNIb1RVWnMxS1pkRjdxVG5xelBkU0pN?=
 =?utf-8?B?djhWaFRqbkRCK2pUdm5oN3o0WUdzamRIaXo3MVBtQmJGKy9nNjhKWVh2RjRa?=
 =?utf-8?B?RjcwdUFTVjBHZ0E2cDdmL2h5SFQxWWdKaUZ2eWpmUVArN2ZiOFhhQ0VVMEVE?=
 =?utf-8?B?bjJReU40QzRlNU1ScC9FN1FuZlVGLzRJWjVEbHplaDlSSmw4NVlCTGpyaS81?=
 =?utf-8?B?OEZsOU1EK2RZYzhVUjdWUmQrNlMxVE1JekwrdmFIdE9IRENEUlZNQyt1b3Y3?=
 =?utf-8?B?dVBueU4yM2F0eWFoSHAxaGovZzArSkc0aHpqYjJQYWUvRGxsOU0za2NJM2lO?=
 =?utf-8?B?YVhJN3dIdVdRU0RaUHVRU2h6ejdGUmV6RHRMVmRCTjdNa2hDTmIyaWFmTzc1?=
 =?utf-8?B?ZGxYcmJYZlVJNmdqUThxMGo3Z1pkN3BuNkh6STVaUEhxRW1wM3NiMGlyblAz?=
 =?utf-8?B?N3U5U3RpZWRBY211ZzJkQlBUV1lwYWlYREZCUFlTenJrSDNPdEhoVEJ4UUI1?=
 =?utf-8?B?UytseU1FbTY5S2MvM3VZZFNuOFY2WnUzMjRtdVh4SEQySmd1NC9CYTdzc0oy?=
 =?utf-8?B?NW80QzRVckRlWC9TMGptRmI3UG10VkIrMWhtN0hUSjdRT2JPK2NGeTZoZ09G?=
 =?utf-8?B?dmkyRUhPaVRsTjAvd3ZRTE5aSHJxTHdWQUtGREJGWEtVRzhWWVI5emFIc1BD?=
 =?utf-8?B?T1pLcTRNdVZGeVVGYkIveDh5UlhVb09xbDg4MGJKd2EvMnljWkhNdXpOZzhF?=
 =?utf-8?B?QTJ4TWJ1K05INkFyYzVlSUVQQW5TZndvVmJkc1QzSnJoaWx3b09kOC9qa3Y5?=
 =?utf-8?B?aEtmbHY1dllWNDQxODFWci9sbEk2VE9Vbzc0TkJSQk52NGFVL1l0QkpOL0F5?=
 =?utf-8?B?L0ZtTjFQM1ZOYit1M2VvVEhoditDM1hQUXZnOWE3L05aMzd0Rng0Y2hneGYw?=
 =?utf-8?B?ZkorRldRN0hsTTdFTFlWRnkzbjZRdUczU092eFJMRk82Zks2aFJYajFZYUZJ?=
 =?utf-8?B?Q1ZJaGwvZXRFdU5udW9TVFdjUnFEWmRrUUVqeFAyeFVaaFdEeFFyYVlTYmdS?=
 =?utf-8?B?ckxnMG1sbm5KTjZWV015d1U0RVZodTU1OWo0dHJRdTVZTnM0OFpPZDdBbUQ1?=
 =?utf-8?B?d1ZmenVYQmliNm5wK2tQYVpYMUdiN2FoV04rM1FPbi9IVDVZalZ0YnBhZ09r?=
 =?utf-8?Q?DQJJ93UtEYfKRzg2gqEEVzqckwKv99dL1e62f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87D78D3B30C1E84E887AC5D1E0FD56A5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f850588-c3bd-44e2-a235-08de52ca388d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 17:36:01.8169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hFGKMJksqSw3qr/YYTELewFr8psAtoKCehNHAA2UGYhhbeEzYb0sHUa2m5YzoimEaZTX2ldByVXN3AywMWu3Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR15MB6976
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE0NCBTYWx0ZWRfX3sJvRKWFW/sY
 /R7mxr5JbXXhutbxDB6lpQaJ3grE5f055aDLza1mVAL9xooMzNvoSygi+i30wEczT2iWJn+zDYQ
 3aAW+xE6Ov1FblPAfDC//wmI7liurkTVx2NBK8AsDVREiR4Jt+FqvWXMQxpC7h87O7zzQbGG2X+
 Jps5ZaZe1N1TZzgxqVOCszcXBIfCu1Yn5wBuxJDp9JduWotyGtAgYRiRdIzSwWCHsaSlndqu9IA
 /nUPnmLQ5Yj1Y6bKuAQQ5RZU4ienSFD7DJdufn+79R3ixHgvtnPgrPqpwDA5l+8gjE4kgiCNS6J
 20pPrs8epZvc07h+9LeY8qNMSC3rcYS3Dst2C+G5VaOVKKS5HmZAGhhJfbOLaNikPWYlbgMkXvL
 WieR5Gg0PU/EcQJae92JIT+4W4nRsGHLEJvNNiNiaWOWOrDxZ9CKBlNEGrI2MiaKkXwGOUL04/Q
 j8p344kE7S7Ad3AVW8Q==
X-Proofpoint-ORIG-GUID: Na2prlrsn9hJ1XRtnHBmWftTgU2_88Y2
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=69668286 cx=c_pps
 a=lV9semjb6HF4qJ8WeHToSQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=wCmvBT1CAAAA:8
 a=BctVfSirecZSET2nUUAA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: wFjJMfWadEvRhdqhM-ktapkCf_kvK31H
Subject: Re:  [PATCH v3 06/16] hfsplus: Report case sensitivity in
 fileattr_get
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601130144

T24gTW9uLCAyMDI2LTAxLTEyIGF0IDEyOjQ2IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
RnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IA0KPiBBZGQgY2Fz
ZSBzZW5zaXRpdml0eSByZXBvcnRpbmcgdG8gdGhlIGV4aXN0aW5nIGhmc3BsdXNfZmlsZWF0dHJf
Z2V0KCkNCj4gZnVuY3Rpb24uIEhGUysgYWx3YXlzIHByZXNlcnZlcyBjYXNlIGF0IHJlc3QuDQo+
IA0KPiBDYXNlIHNlbnNpdGl2aXR5IGRlcGVuZHMgb24gaG93IHRoZSB2b2x1bWUgd2FzIGZvcm1h
dHRlZDogSEZTWA0KPiB2b2x1bWVzIG1heSBiZSBlaXRoZXIgY2FzZS1zZW5zaXRpdmUgb3IgY2Fz
ZS1pbnNlbnNpdGl2ZSwgaW5kaWNhdGVkDQo+IGJ5IHRoZSBIRlNQTFVTX1NCX0NBU0VGT0xEIHN1
cGVyYmxvY2sgZmxhZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5s
ZXZlckBvcmFjbGUuY29tPg0KPiAtLS0NCj4gIGZzL2hmc3BsdXMvaW5vZGUuYyB8IDkgKysrKysr
KysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZnMvaGZzcGx1cy9pbm9kZS5jIGIvZnMvaGZzcGx1cy9pbm9kZS5jDQo+IGluZGV4IDdhZTY3
NDVjYTdhZS4uMGNlOTU2MWMwZjE4IDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2lub2RlLmMN
Cj4gKysrIGIvZnMvaGZzcGx1cy9pbm9kZS5jDQo+IEBAIC02OTQsNiArNjk0LDcgQEAgaW50IGhm
c3BsdXNfZmlsZWF0dHJfZ2V0KHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgc3RydWN0IGZpbGVfa2F0
dHIgKmZhKQ0KPiAgew0KPiAgCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBkX2lub2RlKGRlbnRyeSk7
DQo+ICAJc3RydWN0IGhmc3BsdXNfaW5vZGVfaW5mbyAqaGlwID0gSEZTUExVU19JKGlub2RlKTsN
Cj4gKwlzdHJ1Y3QgaGZzcGx1c19zYl9pbmZvICpzYmkgPSBIRlNQTFVTX1NCKGlub2RlLT5pX3Ni
KTsNCj4gIAl1bnNpZ25lZCBpbnQgZmxhZ3MgPSAwOw0KPiAgDQo+ICAJaWYgKGlub2RlLT5pX2Zs
YWdzICYgU19JTU1VVEFCTEUpDQo+IEBAIC03MDUsNiArNzA2LDE0IEBAIGludCBoZnNwbHVzX2Zp
bGVhdHRyX2dldChzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIHN0cnVjdCBmaWxlX2thdHRyICpmYSkN
Cj4gIA0KPiAgCWZpbGVhdHRyX2ZpbGxfZmxhZ3MoZmEsIGZsYWdzKTsNCj4gIA0KPiArCS8qDQo+
ICsJICogSEZTKyBhbHdheXMgcHJlc2VydmVzIGNhc2UuIENhc2Ugc2Vuc2l0aXZpdHkgZGVwZW5k
cyBvbiBob3cNCj4gKwkgKiB0aGUgZmlsZXN5c3RlbSB3YXMgZm9ybWF0dGVkOiBIRlNYIHZvbHVt
ZXMgbWF5IGJlIGVpdGhlcg0KPiArCSAqIGNhc2Utc2Vuc2l0aXZlIG9yIGNhc2UtaW5zZW5zaXRp
dmUuDQo+ICsJICovDQo+ICsJZmEtPmNhc2VfaW5zZW5zaXRpdmUgPSB0ZXN0X2JpdChIRlNQTFVT
X1NCX0NBU0VGT0xELCAmc2JpLT5mbGFncyk7DQo+ICsJZmEtPmNhc2VfcHJlc2VydmluZyA9IHRy
dWU7DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2YUBkdWJleWtvLmNvbT4NCg0KVGhhbmtz
LA0KU2xhdmEuDQo=

