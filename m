Return-Path: <linux-fsdevel+bounces-46430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA4A891D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 04:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016DE1897253
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 02:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604FB208961;
	Tue, 15 Apr 2025 02:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="CZEhh3lU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37BA1F4C84
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 02:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744684081; cv=fail; b=oiEu06HhMYmq9pf3jPmgZDyxPGLKyt70S5wUoDOvopH6iNLi0UodPJKqn7dNPxJDmKBFMVklioLKDsVBev32LoX2fpM7UZvfzGOi79gl+j/GKNnKonilDDQopNz/Y9j8pbc6s+K/deSsy1MlUzrnVwn53zyXdrpnDF5uTDs6yqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744684081; c=relaxed/simple;
	bh=FCT4TTo1Yg3L5k+NR66728Ts49tJqo7HSzMpeVErPq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eSTZSQMhXwPIp6DxFKidnpeXYQu5MVqaSFUH9aSJnhVmAiv3cQx8aA5RW7dFKA+muPjMX/VtfM6MZHXduzG0CmQvWuMLuLJv1Td5779DFwnNSkz7gvlBryFNc57/6mY+rZzVOqM8VJ3uiZtgkgkHwKIwTlvuVQ/qxFM+/OwVPSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=CZEhh3lU; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170]) by mx-outbound17-165.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 15 Apr 2025 02:27:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YD0df9onT4kGgf7+P11cmJ8Zn4LDe2bcII8u+Kbgs9zh0nHSDtSBD5velo1aeGo8NnA3kXyLPKecjoBSrzwMwOWBTcET4QeiefKRu7RDpilg05/1tJWT7ah4Ne7yYNKZh7IFha0icJNQ/oZxQWcu4eyEKrg8Csp7dEj2MkVbmZ+Vgnao0TmhJr1KsF0b0NACTg0noRXxfRKIMYppcXic6eYlfcBQUE7XoDZwmEt4N72lBAwWDx9wBC9rWhPSJGVa9ZrHBNPHnHII0brQb9W9HChH7YqB96ZVgg9P/zUg30h84Lw2WsoKGHPs/bFPLbdJou04nqFHJmcFs7Gp6xKiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCT4TTo1Yg3L5k+NR66728Ts49tJqo7HSzMpeVErPq8=;
 b=fJHlRGl8ivmp9zywazecUKq6c8geDBKsqMiA3vpjO5F5s7YHxA9ZgsjIPHq0j+t+4CZtG33gBuFDg4t9GjAY2heBzYaJdDIxZ+OR+gQhqq9qEU4SiaJSVdRQdC28rCEMWMFLdHi7qsd271LA7zNkmCcGJZnwZIaU8iqJMe/tU7lVPNWM6BL9xoqqWxnuCODwjoJ/hSlFWEwCItHYZFXhXwhMeylh9vGropUa6wcopAIUo9/fuYuzvOyNyYI+Wm0XQaTfZ6lW0rTc3DB5IKNprKYziQeFCqEMKigBhFp0JdmizaSQF3MIGvav8ZkJhDL6Ays74mopNi7hliRR3KGDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCT4TTo1Yg3L5k+NR66728Ts49tJqo7HSzMpeVErPq8=;
 b=CZEhh3lUnBOY/CKuzJXgg4rAhoI/WiYi+8TOSV/SW4akufeUkTX67BE9HA086wnP3UiKg3a36eOy05fONw33ze3vvcvXSYS90uMWtHPyBA3Coodd8/XZSMKuD+KyXKOaskHilNZ7VdL+miyXenRwDiaDW7PBOKx/4JUvbKR7ALw=
Received: from BN6PR19MB3187.namprd19.prod.outlook.com (2603:10b6:405:7d::33)
 by CH4PR19MB8800.namprd19.prod.outlook.com (2603:10b6:610:230::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 02:27:53 +0000
Received: from BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00]) by BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00%5]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 02:27:52 +0000
From: Guang Yuan Wu <gwu@ddn.com>
To: Bernd Schubert <bschubert@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "mszeredi@redhat.com" <mszeredi@redhat.com>
Subject: Re: [PATCH] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Topic: [PATCH] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Index: AQHbqVp0M67N/vLLOUi6vmMAtVcZE7Ob5/IAgACafqOABr8OgIAAwCVQ
Date: Tue, 15 Apr 2025 02:27:52 +0000
Message-ID:
 <BN6PR19MB31873E7436880C281AACBB6DBEB22@BN6PR19MB3187.namprd19.prod.outlook.com>
References:
 <BN6PR19MB3187A23CBCF47675F539ADB6BEB42@BN6PR19MB3187.namprd19.prod.outlook.com>
 <91d848c6-ea64-4698-86bd-51935b68f31b@ddn.com>
 <BN6PR19MB31876925E7BC6D34E7AAD338BEB72@BN6PR19MB3187.namprd19.prod.outlook.com>
 <8b6ab13d-701e-4690-a8b6-8f671f7ea57a@ddn.com>
In-Reply-To: <8b6ab13d-701e-4690-a8b6-8f671f7ea57a@ddn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR19MB3187:EE_|CH4PR19MB8800:EE_
x-ms-office365-filtering-correlation-id: 3b17f63a-2aca-4aa3-912d-08dd7bc51f86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Sa8mcn8ndpZ2wtXuJ8j6dymtmnASIy/9iDaOn6lYOUwh6nzstc7jMBGFWQ?=
 =?iso-8859-1?Q?4eLh6JMB/QvqoREsN3OaP6ytTawGzAJBEsj9LWpVoI+tPfqCxZxLfQetjj?=
 =?iso-8859-1?Q?8vZoVrW2o/oKVTYV32CPiwDRKVec09SzwAu503GlQapclUBLgTz/R7iY1G?=
 =?iso-8859-1?Q?clEEY9FAMRqXRW3mkrERrb8mAQOh6J6c7gL/e6duAFG0HVqUCOWI5Rvkwb?=
 =?iso-8859-1?Q?doJsT7NPgcMnXNb8Z8sNYx0rKWkl3sMSvscvkrhc59WMPDvYmfHt5HFG90?=
 =?iso-8859-1?Q?MQ+zngPas9X19CVJmRYc5RL/XfHJMQ1MRJ6OBE69MD0yRvu9CSA+kJaClG?=
 =?iso-8859-1?Q?Nzxnk9fLnLdeHl2wk8l/mbsc+QL2UlDFY1K2Y3wJvp0iik8uft3y5m9fk+?=
 =?iso-8859-1?Q?dW5XnnWJdETagO+I8i0/fgO0RdHEKdaMAaqpFdpq4OWEaQQZd0ewYvRp7n?=
 =?iso-8859-1?Q?JxI3BShptWNsYZE3zWKgK4CXP5eP1ECx7n1C/Y1Dn7owr3F/OOuQiTSTYP?=
 =?iso-8859-1?Q?C3nZ0/zqVRNOJfI9FMCLTR0beFZnNs1LEonTmC8GzTEXCm3blNG7XF4z60?=
 =?iso-8859-1?Q?8+NmJsx2nalfXVjT3I1q9Q73yVuNHg+5hiGDfL7rYsAxyUsHYRcn6xYozi?=
 =?iso-8859-1?Q?NfeoEEP73A+Ya7MyLTF4agqMFCv5Fh3L2gsaEEa57reO55orN7IDnfFzvL?=
 =?iso-8859-1?Q?KrBu8TzSLa+GQS6AuFXArQPqePpm22IH8vWQ4uGKwLQvx3k7fC5kQ5XCxK?=
 =?iso-8859-1?Q?XT97wJPJ4x+SaYUlN21dmbcMfP/jIfDPDIjbjY+SZI0CifBvAjqjwBFyHZ?=
 =?iso-8859-1?Q?MAua48+HlcvTEVub6yRb8Sx7Mx+mWuPWXGT3hih058ic3wa6s6tSgT7zpo?=
 =?iso-8859-1?Q?zmQDr1U2yhNnKf7CXys3NlNyaI+Jqx0Ff9BELnH+aSWjfzfrUUs1Fo99bq?=
 =?iso-8859-1?Q?WKyOfZsSTPULMzABpSN1YFUR7WTjse1vGCSxtAOGglKA+DCCTkFUNtkCD5?=
 =?iso-8859-1?Q?ZAnoZVUMw00bEexOEYhknKtTDs4nO2XhtXV1xaOBWLtQDic/V/MNbq1Mv1?=
 =?iso-8859-1?Q?cUgpOJ9VR4Tp7dApfLd/lDZn7RkeJ490MhtBgBAZyk7Ygety118VOAkmtx?=
 =?iso-8859-1?Q?ecnQMkd6v6TjExrU4e512N8sVAYmfxEwtSDEIrRJWYrdxUTSFtSqVU3yKt?=
 =?iso-8859-1?Q?01IrYgDQMBdFMpJCl37po81dYf1siZcZIKAb0BUQK/Xt2Dyjz0gKRiXcPB?=
 =?iso-8859-1?Q?PfjGhl8JTmhYWLzGrxAtxV2wtjB/tC5kmPE8wbLyrvcgSWVbFfL+2cI8b6?=
 =?iso-8859-1?Q?KR/M1C+42P9ZB84dl5NRHW9foMh1xarQVUsATrnhmGR3u8nvpqKWsFmuij?=
 =?iso-8859-1?Q?y7+VkmiiWK8ne5nZ3Gyt9NWNMpQQOe4uFPn5pFCMeXMwS6KxFMKTWnksBA?=
 =?iso-8859-1?Q?jMwRyEcZwXaiRjcxcuD2uOvFEDnQn7FjdNC5tXXGHzS1n65ioHR02x1Ri7?=
 =?iso-8859-1?Q?Ta+6XqXddly/ekymICQ9Pc4CtEc9aathza0H+V5XGWRw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR19MB3187.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PCzL/Ch5AqxNRiPeUxdAfOaHbp4jlKJ5c48Mu6GZ7cOhbZOfLIy61kDXDY?=
 =?iso-8859-1?Q?RcKDPyBWjiJYVa5x8B2JLtoOmayj7tsWtMaCOgHVouJTAVlbyC0dQf9T3S?=
 =?iso-8859-1?Q?RmgzINhUMvLjn9RYUhChy5uasd1RJrQv5f/TuRdjszr6aJzuci76O0kyym?=
 =?iso-8859-1?Q?k7J1dbP4hPUpAEbQks7LbY1lU7vNXsNIc246sNinVGAXwTpTSnSksPCqBK?=
 =?iso-8859-1?Q?sVnzEayRUaES38Dv5N+RTWqmAr1oa6VarR5V00c5WQfkADtmvTAiFaDoeq?=
 =?iso-8859-1?Q?FHDIDlgpiGWBgowSs9jnD2CFhb70VZc8pXKIcpjisqG4B41iklT42M9+t9?=
 =?iso-8859-1?Q?5jkaE5r1ctKb5HETus7Of0+SFjsoT1F9bJMRuiOn58den4wK4u2fCHlxbp?=
 =?iso-8859-1?Q?VyqaAqlIU32ByM2C7CAQyDUhwuC/tkDs4nPdGpoWg54GAecqSyXYh7gLEa?=
 =?iso-8859-1?Q?5Vwy64Z3ovOwOGr3+U5Dbn4rUr1GdXz3VmGn7M2xGx/6cmjr380tHNZOxH?=
 =?iso-8859-1?Q?Z5+efXvblSnX/sG1+wsDJyP399M3XEJdS/9+tUgdq5ZftszvBL3uRHSrJr?=
 =?iso-8859-1?Q?Ken8aVeoB1Ek3dTKOlisPNqj7s5YtBLdDA9CBV4HA/8OfGvFJv4MqUlvSs?=
 =?iso-8859-1?Q?Ng7NnyrWmr52QFldKvfZJhM6+uA9OjBwaKwdohqd1FlvB6xMRi4S82JkEw?=
 =?iso-8859-1?Q?XyGkAmRUwOIKLU+zICQk49a2uBTSL5Rw7jAfBRvaDIz56ZXwHEzd552kOP?=
 =?iso-8859-1?Q?9mQh9fPm0rbP2l303E/oIz07rmnaOmnt0KkBU+DKpIW56M9ixKgPaBzuZr?=
 =?iso-8859-1?Q?aoCrfS7J7arRw8C6tTGIronN/xTFjR/mZISf8nzhXpNazAmmvPzaj3acK2?=
 =?iso-8859-1?Q?akW5BSdtr7uTRlF5/VuBW1nRP1hbqQbV594hic06SFG5Cb85CqRUB+eKT5?=
 =?iso-8859-1?Q?Ltu9YRDHXRzYnrE516hnJk0jhpgcNb3LUqJVeB2Y8kcqvcJZrNpqeSqJTC?=
 =?iso-8859-1?Q?8SzSJ6GwfwAR6f8AZnOH7le8vLdCY/SHThMlOS/yq8nVbztj+YxZN1Zt+j?=
 =?iso-8859-1?Q?tKSiCIY7gLnlEs98TP2LQCAbzQ89HgD0OHkpD1GmVmfSBQNo+oGIeHLi0o?=
 =?iso-8859-1?Q?quwMnhsCLPmSJY//WVLJgq85kMdWRvtYAojhuHzGr8HhH8Si7bXAzwzMr7?=
 =?iso-8859-1?Q?R8QpP0rPmVmTuQodFlnGNWjj1QjcMg7UNUVb0RzVZCY/cZJ/xti1lBr2mU?=
 =?iso-8859-1?Q?+DRqf3E8zO0Mlj6IZ5Cas7g8DegxISQ4+7EjdaKm6jJU0xLzpwyUx7eocZ?=
 =?iso-8859-1?Q?Ijwr2j+d9GMI83ePkMQckSQw+XU6dRkUZT3t3krlnVH199lLkWefThTMXT?=
 =?iso-8859-1?Q?6Bl/MC55CXE/TfNNiUQyXvWKOpjmCdeS8dm2P34grEyzr+EVTRWOyELynI?=
 =?iso-8859-1?Q?xVPQcgQbGqxXHukrWXKH44Mmtw0VBdVv+c7WhduuB698LX+6JD7jaEwZRX?=
 =?iso-8859-1?Q?LU6XUtLqAMXDjhFkhGk7uspLUSWQ0B7VV2Mqa/ZfokzyiUhnv4sdsitM1b?=
 =?iso-8859-1?Q?5xhZG8lwvWZb6Gmkbs+O/vCG7Wp9i1O55nxrAqpmW8MfnJ8dgfraiYKQID?=
 =?iso-8859-1?Q?SDpKEmSXYes1w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xe1Yxtnye/TcIVT8rfbxAoz5catmG80oiIv76XifAJqXPx/4W6TpXAIG3OfJXmbOYf9Q0IjkyrglgmALOER07G+wSXy2R3TvextLSxK/R3XkVuapKGHLUwP2PN/3A9NUjvXWMohESdFiJpoMZhxn4w479H0dxp+uy3f2DKxv/7Xjjjx2x8juTuNmhz/uH+cL/4MSsY8qoQcAqy4lv+LQmufOGC+0XsHOtDfBgG0R45R3DAzFmTOot+SpJqRDdX68vA7rv8ZvB6jjBqKnaTC4EP/ct1xSBqYANzqmb5JcKtC/EW5dNeM5bxakG71I6GqM5PTyw07Wguk6xcnPcZdznh3DdnSZJ/GzNK9WzeMPZXiZEg9/jU7D966etuFyp3lcO4QF3v6hasGv4ElVr+3uqACfTkajd2xIbmBb4rffR1IlIBllDEdm4g8lTaqPVMqqJuIujfrihjogVa3aVlnuyu4NNomlxh/qObs0w5yxoVYLocPeFJF60/JAKQ9+G1pjTobgG2V7GSY19BBIG0rSfaA3XOib+eIaADYQs+IW7HRWsQ7ipSSReXCI73W9RYeN+ZZw6oN6NiGwh4tDoMIiuH/FvMOIifpw9s4OkJ+EFs0VXK9gyz/upCzalafBrZS/ZyZC59vf53pnbBi260LAzQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR19MB3187.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b17f63a-2aca-4aa3-912d-08dd7bc51f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 02:27:52.3566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OefSVj3/bf2KHTA8nfNSL7bJr5hHai1IX2KsT0j9CsuIhtLyPhF59yNEg3qccLDV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR19MB8800
X-BESS-ID: 1744684077-104517-17092-52051-1
X-BESS-VER: 2019.1_20250414.2054
X-BESS-Apparent-Source-IP: 104.47.58.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmZGppZAVgZQ0DIp0SgpNck4OS
	3Z0sjUIiXJxNg0NdUgKTnRPNkw0cxUqTYWAGcgYrdBAAAA
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263895 [from 
	cloudscan20-34.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

=0A=
=0A=
________________________________________=0A=
From: Bernd Schubert=0A=
Sent: Monday, April 14, 2025 10:32 PM=0A=
To: Guang Yuan Wu; linux-fsdevel@vger.kernel.org=0A=
Cc: mszeredi@redhat.com=0A=
Subject: Re: [PATCH] fs/fuse: fix race between concurrent setattr from mult=
iple nodes=0A=
=0A=
=0A=
On 4/10/25 10:21, Guang Yuan Wu wrote:=0A=
> =0A=
> Regards=0A=
> Guang Yuan Wu=0A=
> =0A=
> ________________________________________=0A=
> From: Bernd Schubert=0A=
> Sent: Thursday, April 10, 2025 6:18 AM=0A=
> To: Guang Yuan Wu; linux-fsdevel@vger.kernel.org=0A=
> Cc: mszeredi@redhat.com=0A=
> Subject: Re: [PATCH] fs/fuse: fix race between concurrent setattr from mu=
ltiple nodes=0A=
> =0A=
> =0A=
> On 4/9/25 16:25, Guang Yuan Wu wrote:=0A=
>> =A0fuse: fix race between concurrent setattrs from multiple nodes=0A=
>>=0A=
>> =A0 =A0 When mounting a user-space filesystem on multiple clients, after=
=0A=
>> =A0 =A0 concurrent ->setattr() calls from different node, stale inode at=
tributes=0A=
>> =A0 =A0 may be cached in some node.=0A=
>>=0A=
>> =A0 =A0 This is caused by fuse_setattr() racing with fuse_reverse_inval_=
inode().=0A=
>>=0A=
>> =A0 =A0 When filesystem server receives setattr request, the client node=
 with=0A=
>> =A0 =A0 valid iattr cached will be required to update the fuse_inode's a=
ttr_version=0A=
>> =A0 =A0 and invalidate the cache by fuse_reverse_inval_inode(), and at t=
he next=0A=
>> =A0 =A0 call to ->getattr() they will be fetched from user-space.=0A=
>>=0A=
>> =A0 =A0 The race scenario is:=0A=
>> =A0 =A0 =A0 1. client-1 sends setattr (iattr-1) request to server=0A=
>> =A0 =A0 =A0 2. client-1 receives the reply from server=0A=
>> =A0 =A0 =A0 3. before client-1 updates iattr-1 to the cached attributes =
by=0A=
>> =A0 =A0 =A0 =A0 =A0fuse_change_attributes_common(), server receives anot=
her setattr=0A=
>> =A0 =A0 =A0 =A0 =A0(iattr-2) request from client-2=0A=
>> =A0 =A0 =A0 4. server requests client-1 to update the inode attr_version=
 and=0A=
>> =A0 =A0 =A0 =A0 =A0invalidate the cached iattr, and iattr-1 becomes stal=
ed=0A=
>> =A0 =A0 =A0 5. client-2 receives the reply from server, and caches iattr=
-2=0A=
>> =A0 =A0 =A0 6. continue with step 2, client-1 invokes fuse_change_attrib=
utes_common(),=0A=
>> =A0 =A0 =A0 =A0 =A0and caches iattr-1=0A=
>>=0A=
>> =A0 =A0 The issue has been observed from concurrent of chmod, chown, or =
truncate,=0A=
>> =A0 =A0 which all invoke ->setattr() call.=0A=
>>=0A=
>> =A0 =A0 The solution is to use fuse_inode's attr_version to check whethe=
r the=0A=
>> =A0 =A0 attributes have been modified during the setattr request's lifet=
ime. If so,=0A=
>> =A0 =A0 mark the attributes as stale after fuse_change_attributes_common=
().=0A=
>>=0A=
>> =A0 =A0 Signed-off-by: Guang Yuan Wu <gwu@ddn.com>=0A=
>> ---=0A=
>> =A0fs/fuse/dir.c | 12 ++++++++++++=0A=
>> =A01 file changed, 12 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c=0A=
>> index d58f96d1e9a2..df3a6c995dc6 100644=0A=
>> --- a/fs/fuse/dir.c=0A=
>> +++ b/fs/fuse/dir.c=0A=
>> @@ -1889,6 +1889,8 @@ int fuse_do_setattr(struct dentry *dentry, struct =
iattr *attr,=0A=
>> =A0 =A0 =A0 =A0 int err;=0A=
>> =A0 =A0 =A0 =A0 bool trust_local_cmtime =3D is_wb;=0A=
>> =A0 =A0 =A0 =A0 bool fault_blocked =3D false;=0A=
>> + =A0 =A0 =A0 bool invalidate_attr =3D false;=0A=
>> + =A0 =A0 =A0 u64 attr_version;=0A=
>>=0A=
>> =A0 =A0 =A0 =A0 if (!fc->default_permissions)=0A=
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 attr->ia_valid |=3D ATTR_FORCE;=0A=
>> @@ -1973,6 +1975,8 @@ int fuse_do_setattr(struct dentry *dentry, struct =
iattr *attr,=0A=
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fc->handle_killpriv_v2 && !capable(C=
AP_FSETID))=0A=
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inarg.valid |=3D FATTR_K=
ILL_SUIDGID;=0A=
>> =A0 =A0 =A0 =A0 }=0A=
>> +=0A=
>> + =A0 =A0 =A0 attr_version =3D fuse_get_attr_version(fm->fc);=0A=
>> =A0 =A0 =A0 =A0 fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);=0A=
>> =A0 =A0 =A0 =A0 err =3D fuse_simple_request(fm, &args);=0A=
>> =A0 =A0 =A0 =A0 if (err) {=0A=
>> @@ -1998,9 +2002,17 @@ int fuse_do_setattr(struct dentry *dentry, struct=
 iattr *attr,=0A=
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: clear I_DIRTY_SYNC? */=0A=
>> =A0 =A0 =A0 =A0 }=0A=
>>=0A=
>> + =A0 =A0 =A0 if ((attr_version !=3D 0 && fi->attr_version > attr_versio=
n) ||=0A=
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)=
)=0A=
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 invalidate_attr =3D true;=0A=
>> +=0A=
>> =A0 =A0 =A0 =A0 fuse_change_attributes_common(inode, &outarg.attr, NULL,=
=0A=
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 ATTR_TIMEOUT(&outarg),=0A=
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 fuse_get_cache_mask(inode), 0);=0A=
>> +=0A=
>> + =A0 =A0 =A0 if (invalidate_attr)=0A=
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fuse_invalidate_attr(inode);=0A=
> =0A=
> Thank you, I think the idea is right. Just some questions.=0A=
> I wonder if we need to set attributes at all, when just invaliding=0A=
> them directly after? fuse_change_attributes_i() is just bailing out then?=
=0A=
> Also, do we need to test for FUSE_I_SIZE_UNSTABLE here (truncate related,=
=0A=
> I think) or is just testing for the attribute version enough.=0A=
=0A=
<moved comments inline>=0A=
=0A=
> Hi Bernd,=0A=
> I think in such case, although outarg.attr (reply from server) is staled,=
 =0A=
> but it is still valid attr (pass above fuse_invalid_attr() check).=0A=
> set it and then mark it as stale, is for fsnotify_change() consideration=
=0A=
> after ->setattr() returns, new attr value may be used and could cause=0A=
> potential issue if not set it before ->setattr() returns. Sure, the value=
=0A=
> may be staled and this should be checked by caller.=0A=
> =0A=
> Later, iattr data will be revalidated from the next ->getattr() call.=0A=
=0A=
Good point about fsnotify_change(), would you mind to add a comment about=
=0A=
that?=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 if ((attr_version !=3D 0 && fi->attr_version > attr_ver=
sion) ||=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_bit(FUSE_I_SIZE_UNSTABLE, =
&fi->state)) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Applying attributes, for exa=
mple for fsnotify_change() */=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 invalidate_attr =3D true;=0A=
=0A=
Ack.=0A=
=0A=
> =0A=
> I am unclear why FUSE_I_SIZE_UNSTABLE should be checked here, can you=0A=
> provide more detail ? Thanks.=0A=
=0A=
=0A=
The function itself is setting it on truncate - we can trust attributes=0A=
in that case. I think if we want to test for FUSE_I_SIZE_UNSTABLE, it =0A=
should check for =0A=
=0A=
if ((attr_version !=3D 0 && fi->attr_version > attr_version) ||=0A=
=A0=A0=A0 (test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) && !truncate))=0A=
=0A=
I though about this ...=0A=
Actually, FUSE_I_SIZE_UNSTABLE can be set concurrently, by truncate and oth=
er flow, and if the bit is ONLY set from truncate case, we can trust attrib=
utes, but other flow may set it as well.=0A=
=0A=
FUSE_I_SIZE_UNSTABLE could be expanded to FUSE_I_SIZE_UNSTABLE_TRUNC, FUSE_=
I_SIZE_UNSTABLE_COPY_FILE_RANGE, FUSE_I_SIZE_UNSTABLE_FALLOCATE ....=0A=
and then we can control this much precisely:=0A=
=0A=
if ((attr_version !=3D 0 && fi->attr_version > attr_version) ||=0A=
=A0=A0=A0 (test_bit(FUSE_I_SIZE_UNSTABLE_COPY_FILE_RANGE, &fi->state)) ||=
=0A=
 =A0=A0=A0 (test_bit(FUSE_I_SIZE_UNSTABLE_FALLOCATE, &fi->state)) ...)=0A=
=0A=
Thanks,=0A=
Bernd=0A=
=0A=
=0A=

