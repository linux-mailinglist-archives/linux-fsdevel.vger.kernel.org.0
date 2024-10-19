Return-Path: <linux-fsdevel+bounces-32433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60B49A506A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 21:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74041C21AE6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 19:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DE91917CE;
	Sat, 19 Oct 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcAVXuZ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10CF18DF84;
	Sat, 19 Oct 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729365032; cv=fail; b=WaSD5EUJvq0Es/KnBcpSzPOYtZB7PRQjW1nGQ29s1OqwtU/0V3dFJZ6JVuarnl0quI16h5JPWI/W8G01enfF3rOictANZ7VgtfWdQhde6zprb6fuUeWbHMd4uJ1Y+XO6GYLiis0XJNIb86dJQ/FJNZ+AB9qpAnAA/BGj/tik65A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729365032; c=relaxed/simple;
	bh=Vu/o71jH0zBdSZqKf34k7RhmIYqPfPkpEqD/Z+WgUqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Na8VqvDT7ygU/Z5kG156A7OBMbdRNSNrcQkpvD9Kmhyj9pxiHq95YRhvQL5GzL6bob1k9ak9wDfqnZwBmR8PKL/IukmnTBy7kQj66gKzxi4NSFbsRwCFogUNpIDfoaXW6npnC7BLc2qw585D5RvPuHBPE2n3PPpQpX60tg6rWgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcAVXuZ4; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729365031; x=1760901031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vu/o71jH0zBdSZqKf34k7RhmIYqPfPkpEqD/Z+WgUqI=;
  b=AcAVXuZ4fu6AD+xLlRTQwCGOO0J40zJvfkI3xuT7yICsdhrxAtjuMw6O
   CI3YlgVeU0xDcFkQ8S2AVFb0FpHY3jUT2KlY+UOz9nZisgT/wu2Glqa5p
   eplY69cQbdX4kVVklSQQKGm9PNvkgyyL51IsOKtDlU5wSomAimoy9KJDh
   Wg5BscPEifiMJHNlVv3eKGS+mq8GjLBpZgkbYtzuvZ4F7RSDl5+TjkyFm
   fMs5IYFcaMKxHu3EwWvBb9sfcN1BeiTmcW7y/vF91mfvj7HvhQTuBHzh1
   SE+dS3HTnp3oWveVY4RNNL+OtTOLklPgSeLTyDHqrmoTbb5ohPi2YahOT
   w==;
X-CSE-ConnectionGUID: HEdXl8gaTZ2QSVZ0GQ+iMQ==
X-CSE-MsgGUID: TLEgdkhfQ0qQGplkc42SZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28761373"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28761373"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 12:10:30 -0700
X-CSE-ConnectionGUID: epTqDVQvTquKcWZDgjvuLg==
X-CSE-MsgGUID: F3hXcmriQWC4YSOEglgAEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="79559057"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2024 12:10:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 19 Oct 2024 12:10:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 19 Oct 2024 12:10:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 19 Oct 2024 12:10:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 19 Oct 2024 12:10:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuDMT61OZbAIscXwrRjDZYGNNoh20ijjB3uADaaFVDxJMB33jD+vvJwgF62AAE8mXWuF60VWafLTaA6Vwhhr5/WT1EqiIhftQFtITbhg/+9VfyWDdC9O3rUg84N2fpEcdoVfbxjQLs7/dceot7wPFNsyugPirOWfpIYXQZfYn3QoEoOncJmRw4vNbqupfOTiWI39LAogTi868PE4ADFysB5dmil5YXtWqWoPif/cXEUNg60lhNImez0cMer3IBeDtKRlVfooqnLw4MvJYkhcH1+muEAsTXDTklYwsqE7ciLJm3nWIx8MLxDpPDoH/firZjVJtUVO4CQUrmw3Ajp5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm3c5Yzot/6Ae9y2Z4/idnMYx549iomRbeWU6n9p4z0=;
 b=O0+OBk4U70+ydm9VzUf0ZJhCylKliLUV3EjJe1enntwruYLfnpu1g4FeQDnfH8W2ocGRjxPgucyMAh1PIkdhRbre4wuZju2tHVRK7MW4nN0zqpVRi4nQT4zgHVR5Ti2i+XuEaR8e1Xgmi8/qO0fgUARfuh5BB3RGZNh2grabdfWSFr5aEOkC0ImyH0RY9NWj685xbRgmuYBSXE6+48H1EPZPedD9eIwLXFsNSH+I2rooheRxhLj+v0/0cZ6nODpOJ5VfFGy6AdPdK24uRv6gscdR5PlF7U4Vz66xAemRCF2huDRwf9cae1GGetEqH0kJSt1YCbbYE/5s79k5Q5oWCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH7PR11MB7594.namprd11.prod.outlook.com (2603:10b6:510:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 19:10:20 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8069.024; Sat, 19 Oct 2024
 19:10:19 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "clabbe@baylibre.com"
	<clabbe@baylibre.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>, "surenb@google.com"
	<surenb@google.com>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
	"zanussi@kernel.org" <zanussi@kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>, "joel.granados@kernel.org"
	<joel.granados@kernel.org>, "bfoster@redhat.com" <bfoster@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [RFC PATCH v1 01/13] crypto: acomp - Add a poll() operation to
 acomp_alg and acomp_req
Thread-Topic: [RFC PATCH v1 01/13] crypto: acomp - Add a poll() operation to
 acomp_alg and acomp_req
Thread-Index: AQHbISi3RijobI6hNEW+Nkk4X+Po8rKMI8mAgAD3FUCAABwNgIABOmug
Date: Sat, 19 Oct 2024 19:10:19 +0000
Message-ID: <SJ0PR11MB56787511CBC1AC1C588BD46AC9412@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <20241018064101.336232-2-kanchana.p.sridhar@intel.com>
 <ZxIUXX-FGxOO1qy1@gondor.apana.org.au>
 <SJ0PR11MB5678CE94DDBDEC00EA693293C9402@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <ZxL7KUGUroiOYssf@gondor.apana.org.au>
In-Reply-To: <ZxL7KUGUroiOYssf@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH7PR11MB7594:EE_
x-ms-office365-filtering-correlation-id: f151d0f8-2f65-4f32-7ba0-08dcf071acaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6uEtPWZpEUJaksN+vM4yuDzlmW9sKTqae1prGa14975qa9VHv63qg8Ed64LD?=
 =?us-ascii?Q?5sBe6LT+0fUiZZ6QZ/mtWr0tDek8SiAJtnpb9/mkLuIg7qrTFMZRbxbn5zWF?=
 =?us-ascii?Q?PFSX2RJIWXyjpJ3dLs2j/oNMzvbZv+DPxqiKmP7eH71QnRmIpjYWFxpCMzBf?=
 =?us-ascii?Q?G48jgkIgaONFRaXKSeV36xYILPaK0YSwIfvL4Ui5Q5eRSSZ+aZdFevBFPhUk?=
 =?us-ascii?Q?sFw0PPWMslctVnOoC+t3sl5s9Exu6T4EsfBHLFSRcmkeTD9JKu2W7PVICwt/?=
 =?us-ascii?Q?UpJ8aN1L+4LYmRGq95sghvCrkvjwF+8zNZbIp74UdjCmd+DalRvpnIg02Ol5?=
 =?us-ascii?Q?4gL5VGoGWgrQkh0rgJKJBSTg9n17TNHCtgc6KGg4g80L4CvEq40Cg8OozxWY?=
 =?us-ascii?Q?eDTSlENyPOMdLibPdRSCMDXXivuiweqkOEjvkazIifeQg0VTwDdtZhQ1amfh?=
 =?us-ascii?Q?93xvsHwVazyUi2Kttbf01kuktO70Nw+0w/AdUqtUIGWTC31nVaVk4Br5uRTJ?=
 =?us-ascii?Q?djZm/gI70Rwa579P1DRpwBkiWxGMFAiAbxno5ADHrkerJ37aE7EwgwMSe0J4?=
 =?us-ascii?Q?uZvifuP89Ar1CkUe/C1QslbsEJwJb9jIXcjSngFhcJlKy7YULJCvE0AykiLI?=
 =?us-ascii?Q?vttwa7yZBTghu1A/TE88Vn6qu6oeUsmGSG2z+bH0WULnbOokm+DWfGvZMJf5?=
 =?us-ascii?Q?+H6FyhupbVR9kYR/DF2W0bQw268/S8nRYKMJeWAf0h8nslctUdEIUrbjzO6a?=
 =?us-ascii?Q?qp+pO2UdzxxhkwY76E+DuAzVoqOoOzJq9GA1AJ+DwS1kZgrpkLeQsZPJZTX1?=
 =?us-ascii?Q?DxndI6arYN2VzXsadbuY6sGalk6zXV6VirqQMPWdaV+tSB6R8D97QAWESlGc?=
 =?us-ascii?Q?WZaYmlgH6DnSwEhYjSQL2/vUnuJucrRBn1SQTFKpIMpVffUAswpxrRA8WGzo?=
 =?us-ascii?Q?qtA5HxC8IPHtZjQBfe0V/Df6DNMa9t9ubdd8SL1gzg5a9ZL7PUi/Stm+UCoJ?=
 =?us-ascii?Q?NkyYnLw2gpIwRIjysd4SshWFuxGydQ77k1cHCmYTq5Ii5SiLc+Zwuh+niNUg?=
 =?us-ascii?Q?eqPGMi5qIlpEZwnh6uys4rpgZw2x+RBDybgHW8CPzHNMTgell6iKVWZv9PdV?=
 =?us-ascii?Q?1FF2MQfqblpZdWdCGsshcFjznWtkUdgleHCK/7YUlnHodvJGFbEbim9AKV+n?=
 =?us-ascii?Q?3AoYQ+Er/EQ67CzGhd9Y9/yhy71FDP06YnT4jPMDAclxln+hp8QBFaEnNKyD?=
 =?us-ascii?Q?ClXNcBVupQExrOfJ1QtjZ2L/77pO5+Ee+Ih9Di/lS+D7EcfsyRcAAclx9AWg?=
 =?us-ascii?Q?B6y75y7HH/mntlvmFLidC7Zy?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dWuSnn0EbYq8/wf14v1mhsjqOTQLHlvuZMTMzLkDj5wiHzsHjVGKFy1PgN2M?=
 =?us-ascii?Q?pdeK65psugne2zcM9c4OJH2V/vQ379dJLZ7Q/Pry71HboUBXSlwL5L8zK+9G?=
 =?us-ascii?Q?hir9CGyMk0iL6tKfTpC3/85X9cWABhE+6aOS4p/K5Y2gcYyoWSPZyFTBeyNO?=
 =?us-ascii?Q?8T8TcCzgq4NWs5NV/p8XjrWPPwFjoUleYaUQUtR4fX50aCwQ5N6E5qSOIkWK?=
 =?us-ascii?Q?STOQLHYH7DFWlZ3YwKX4Bu5/9aFAdxpbk1nbytG2GJa8LfUvp575O27t8t2R?=
 =?us-ascii?Q?eGByYUozkuIcD04jsk9nEnzZ+Dy4GDxdjFCdjZP8H7yo9Z0lMDYrXRsT72jR?=
 =?us-ascii?Q?rgQfpLoUBNTH6FnXvNTwZIPfNGBG0BHABohzVrUFoRcruLL+8PmIQEX4Smlc?=
 =?us-ascii?Q?Y3AHeoYoJAGSnZny5rLV1+pENRhFxgRGkFfJQVtiHZMnfOR+opmTKByqbvBY?=
 =?us-ascii?Q?gpLeX0BqFXOZ7tDZyKlxZ5rTbpxLgQ6wIxGZq43kHt+C2RhyYqK4pMvfXWxp?=
 =?us-ascii?Q?A4O7wNQYDMn14M3JAY6JCxFcRjzv+GEuGiD7PbHqEiGxJk0fx7DDX4WBbgtr?=
 =?us-ascii?Q?aELgKKA/8to5AiFRS2U9AMAn3kRQmq2JUnpV6je+M5FsTqPFIjRCdoB+bKye?=
 =?us-ascii?Q?5ldWPOwdLfFWj+WrrLq9sCF0g8zrq9vbM9KEer8Vv9vEBnrngEvzVijFsNkk?=
 =?us-ascii?Q?PxYiUJGQbPBCV3fKc5Sw73sk8lg7GANM01nWfVBpEgkMy2QASwI3bRTNZ7EH?=
 =?us-ascii?Q?VK3lkR1l/EjSeFei7wCpntqP7jEFqwDhADhjz0KDZq95l4XtaiZwMShqzblU?=
 =?us-ascii?Q?yYWAY6FY0RJefhm4YI3L7AEWRO+soyQFQEmLU9ABUj2jcHELJsYBy8EKkJvo?=
 =?us-ascii?Q?USu6PzEMrutrsluO2qTjd1hfXYVFjAMlK6BH4o/qWqf9XDW8AsXyYmmAjGeB?=
 =?us-ascii?Q?ipqV5i7rJIZbnvKPcV8uSjnbZyvSeHshyobYwNRML+IvXeKCTUtCROuTqvDc?=
 =?us-ascii?Q?/jNFUOZhtr0vEUTb8/zH4iHCEB0ir3NZxGIh38Rq2ql3u2DZWPFOMma63Jcf?=
 =?us-ascii?Q?JuHEWe8D3zmc9ONH60VhC4J2yEG9jwT3eUquNk7wV/nQcKqFJv//Ery4TZYl?=
 =?us-ascii?Q?6Gt021C5v1ENqm6rhxgPIq4Q846EnWVejaekWNM+RgsPp13lMVjtDddhaZeh?=
 =?us-ascii?Q?lluWoFLYm6L9oEDFCl9tSgvnqY913LfdblmV0mSDXV9IGSthaDsLjYtLQVQF?=
 =?us-ascii?Q?7+0CoNbVlDqw1/irV7JMDpcUmovIxzdpJDZhrd4mw0p9NtLyDc2+5pp/pH/b?=
 =?us-ascii?Q?FytOeSxzJl4PhSlhBk3Vxy8yPPVUyRA5wKBGni6Dg7gEjlG9tkt4/oaLGKSK?=
 =?us-ascii?Q?KPm5AQQbUoT/0yhuk2af0UAmy1sUlFGJSUvSk56q4L5lfeKUlL/mvR+z3fDj?=
 =?us-ascii?Q?DKbTv0ItK51caLggl2+/ljwDfsnnzSjBTvN/8cHKoUu3Uzcw47J62GT4ZPQ3?=
 =?us-ascii?Q?E9UdoYu4QiLiCaUGrb2ccC0I+LFkA3STPfuDZNx5RDcFfTV+xtKsgDWftPbc?=
 =?us-ascii?Q?CfCW8vSHlKhPjw3gno2CUtQJaMJeBBAUr1qxGKi/ZERLLMDBcuMnJRTZFlvL?=
 =?us-ascii?Q?omcX+sEJ4ra4K6f9hzyw8bo6PFl/AsuXRp+BE1je5LL0SCkiSrx8qtMYTPHe?=
 =?us-ascii?Q?lA5j8g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f151d0f8-2f65-4f32-7ba0-08dcf071acaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 19:10:19.8851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZmSz8zpdSSVwEHiq7qjlnsDqRsmJfuGN6dZ7QFlncdspAIFU+N5bG7yUSbWurfNfCAV8eIya3tWwhlnM2VILiHH7Xo2As8nfAPsp9OBFC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7594
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Friday, October 18, 2024 5:20 PM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
> 21cnbao@gmail.com; akpm@linux-foundation.org; linux-
> crypto@vger.kernel.org; davem@davemloft.net; clabbe@baylibre.com;
> ardb@kernel.org; ebiggers@google.com; surenb@google.com; Accardi,
> Kristen C <kristen.c.accardi@intel.com>; zanussi@kernel.org;
> viro@zeniv.linux.org.uk; brauner@kernel.org; jack@suse.cz;
> mcgrof@kernel.org; kees@kernel.org; joel.granados@kernel.org;
> bfoster@redhat.com; willy@infradead.org; linux-fsdevel@vger.kernel.org;
> Feghali, Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> <vinodh.gopal@intel.com>
> Subject: Re: [RFC PATCH v1 01/13] crypto: acomp - Add a poll() operation =
to
> acomp_alg and acomp_req
>=20
> On Fri, Oct 18, 2024 at 11:01:10PM +0000, Sridhar, Kanchana P wrote:
> >
> > Thanks for your code review comments. Are you referring to how the
> > async/poll interface is enabled at the level of say zswap (by setting a
> > flag in the acomp_req), followed by the iaa_crypto driver testing for
> > the flag and submitting the request and returning -EINPROGRESS.
> > Wouldn't we still need a separate API to do the polling?
>=20
> Correct me if I'm wrong, but I think what you want to do is this:
>=20
> 	crypto_acomp_compress(req)
> 	crypto_acomp_poll(req)
>=20
> So instead of adding this interface, where the poll essentially
> turns the request synchronous, just move this logic into the driver,
> based on a flag bit in req.

Thanks Herbert, for this suggestion. I understand this better now,
and will work with Kristen for addressing this in v2.

Thanks,
Kanchana

>=20
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

