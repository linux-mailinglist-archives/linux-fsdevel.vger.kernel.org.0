Return-Path: <linux-fsdevel+bounces-38543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1941EA036A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C183A3061
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19021F2C44;
	Tue,  7 Jan 2025 03:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UhWqHm0w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6421F2383;
	Tue,  7 Jan 2025 03:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221507; cv=fail; b=b8WbafBoNI48TiTpdMKZHDA9N7AxB2zPUzOxLjixGeM2psn4GhPTtJR5jRUsJYMyvUwA1/fOkofaDv8VaSrVTEuGSFNY9Ee7JFuo53LMWBMRcTZEePo3spppqZmLKEr2fRCjmg7Qvv9W81Q+YRq5D6X/le4wJLxN6zpislka4Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221507; c=relaxed/simple;
	bh=/Csrylkm2NidU986QPWqaDZpz+jU+FcWBDetRvEORiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RilaZx+hHb9886TJmdtSZO5Rkc1w+hDMRZsJGKBUE2YkZR63DIjZl5aJcmZrVZ10bd9NnKUpqp0V+YeZZlMYUVZjdzuKGdghSUKrVK63+rr0efEHgyUZZRnY+LvRx3Hhc+/c/PecjTfeFiRrb8Luo9WZ9gj2Nr9tplzDK9cNa+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UhWqHm0w; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAwdafQgHrkbs9Ka9ucH12AvxcmFUoNKvqKAPBiBFdF/jvUIzYy/IjT0Ou/j09j0ATKaGCRgZba6GWhFGF1Du5aUH99EoClHOTZ5oERIIwk+GeOCj0OV7TjcjW2iiOEu64LtI+Zir6I3VKDUz1ZOSCHhNRZXH4Vdz6C6bEzP6DiQw8EHq88k51w5qjhricxbEk+v7PpwlDn3LVkC0UJ1vj7FY9QMZZ6hKZkHKgtufr2LHzEfLYbvOLCg2XiyfvKFWL4x0CEEq5bFvDRfi2xXbPLtmcL8vIlHP6x/HPdXmS+ToaWIs6zIZULxWda7+EDG5OdSlAb14X3UBmZ2lovNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANnS9ugPhWXEhOP/c+FzNHxXqu35Gn0O+fqlriZg1uw=;
 b=K0gJyfR60c/VtjEZcFQh4hLUk0rt1WzvK9wm2wXlIqeMfALQXR2pZLYR59ZKBIjGyxbBcBXO6tx1sqxWXguHHCBFqsljzCxx9GXm+A7VVXq6X+XZFzfg/qk6gkFj9d5cFhq39gUq6ou7DjmmGQi6vNEas2DHm389vh3C8/EEeF66oD5EP/i1knLoHrXZR4JCA8wYTifM5YRzfHhEDjx0dGYoZT6HxD2oxbA2/FSQn7/J2CHHQ0cxROUeO1ndIICrWmTLhuzO4aJ77CgEzBgwxCCw2xqv6mF2QTrVfhqRHxifYwTDajhkt1WbTteOT1QI2Zcjv+fVTQTpil8KRklaag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANnS9ugPhWXEhOP/c+FzNHxXqu35Gn0O+fqlriZg1uw=;
 b=UhWqHm0wjUU9aCOVk7/E6R+DMTc6E6MCDADiyqSO1ERebhhsO4GyZE95zhc1Yq6t2hwS74YnSstlwWyu3nqbIG4cAg9/1adbcyFWzvrU/gUTjp3qwpsypkSz6nI4LUC9v6kt0mcLWp7AtUUoPezGYaujwP0g8+nKLK7MU5s/iNEJrzEmtN6RIQs8sZGYIYCKqZAEZ+mMCdRPoyb5+naerAkCo+ZI5U2iZfl8nG7CjQ7cCJq8KcLN8DLwq9OgOC/CduiCMHCWyB6b1cooMmudq0T0wqObfHzx54uZrJDoJIUtgdt2kVJWh5wJd+CLM4f0LEKfrmOsDHq6k2/YyrJF4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Tue, 7 Jan 2025 03:44:51 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:44:51 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v5 25/25] Revert "riscv: mm: Add support for ZONE_DEVICE"
Date: Tue,  7 Jan 2025 14:42:41 +1100
Message-ID: <dd557b20d49a08f6172e6cff76753850300fda57.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY2PR01CA0019.ausprd01.prod.outlook.com
 (2603:10c6:1:14::31) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 4111b1ca-e898-4028-28bd-08dd2ecda415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vm5kZDNSK0c0bmxhbWFsTGl4Nm1GYWdlT0lLMWR3MkxmcVBkZ3ZpOXN6djVh?=
 =?utf-8?B?NEIyb1NicEZvUkhadXNnNnpJaTFYWW84dWkrcjVLanhKbmpQUm9IbE1nSHBz?=
 =?utf-8?B?QnZ2Z1ptVkM2NGRnN0plZmMxcS9GZkRLUVpmZEp3UDJJVXgwb3Q2emxDUC80?=
 =?utf-8?B?WlE5Y0kreFhQSER1T3JWZCtTT2REMVVxdm5EZjFvSjlSMU1waXdtanJxY215?=
 =?utf-8?B?cTdCVUJ6Yk55dXB3NGkwSVQ3OWlrMUJDNmZVZXBDblArbi9FMHBTTEdReEg1?=
 =?utf-8?B?d1lsMFlIeXUyZW1GYTE0b3FWVVM4WG1ySDg3dmN5YXFVc1ZxQzlWRnNqR1JV?=
 =?utf-8?B?VXo2cWkzOE92Ny82WUNjbFI5OGNzcEhUb1hlaldaUm93TFppdHdOMDU0ZWV3?=
 =?utf-8?B?Tm1yN0Mvc3NJeHZOTkdWYWc3Vm9tUkFRemxoTzYwRno4dTZPU0kzMXYzR1g4?=
 =?utf-8?B?Tk83c3Y3cnh1TVlNaERWaUhhV1kyQTExSmp6RWE2UHRHcWF3V3hCZlhVbzl4?=
 =?utf-8?B?NG54UE1vVVVHVHAxdGlvNDY1L3c2UGtvZ2g2T0ZWZmMxTHZMRk1PTlZOTjl6?=
 =?utf-8?B?bEphMjlYMk5kVlNhM2g2a0kzeUxzMEZjR3k4S1FYbzFGR0VjbWl3aFByZVpQ?=
 =?utf-8?B?RFM2VkR0UXp5bEx2Z0dwbEd2dXN1TzFRZmhVdDllRzVuSXQzYzkxMFdEbXN3?=
 =?utf-8?B?Mm9ZYys5STNHOGdpSkcyZzVSOTZTc3RuaUF5TmhvaVhOd0l4WEtScXhIY3NS?=
 =?utf-8?B?NUhOS2htR292UjZXd294OFN1QnBGSHNPVGVhMjMzZUZWTjZRUE1jWFBIUU1v?=
 =?utf-8?B?Q2lYSFBJWVJOakZvWGl3cFNNZzVMTnVVUGxmekxGMWpQU2tsNmtta0VaV1d5?=
 =?utf-8?B?c0ZkRFZmVitXc2drV1lEbVpja3AwdHZaRk1hSUNCdTdBYTNOTnRYbVRXZ0U5?=
 =?utf-8?B?YmN0Vnk3MFUyUk5hTzUrbi9ZU0lwV1F4b1BwcHBDQzJZWHFZSUhDWm5IbFJZ?=
 =?utf-8?B?b0hidlFhbG9CYjk1dy9aSlR0YmRTUitxMnh5dTdKR0w4aGI3K1R6VTlYRjds?=
 =?utf-8?B?R3BlZ3JVSy9XS1AwVjlOakk3emMybXp3a0hVOFJOa0lZR1pKcWlBVkhxS1g0?=
 =?utf-8?B?UVFpNnVMMEtQeG4ya2lLZHo3YlB5dWpYT1FnNzZ5cFN5TXcwS0xhVTNUb1RY?=
 =?utf-8?B?V1U1dVhLM2FOb3ZDY2NmaHcrV0FBR3drTUtyR2dIOVVWNjUvblNQM2czNU4v?=
 =?utf-8?B?cmNJZFZkTUxURTg4VGZJSHYyVFI3Y1hqTStKaUVPSUF4ZjdTTGlocXZ2dTVL?=
 =?utf-8?B?djBBKzl0VXQ4YlJqMlBaM2FOcGUzV0VkZ0diNkhQTkE5MlhSM2J4SDkzd0xh?=
 =?utf-8?B?SExaSDRlQnV4YmRXZlkwM2Q3R0lQTEh3T2FQZU1JYWdhR3FxTktFOGU4U2s2?=
 =?utf-8?B?em9PY0ZZT3FJS3p6Zm1WY3EyUmtjNHBKZVRxeHU2MFVyYlc0cFRkMUFLMHg5?=
 =?utf-8?B?TGxGRHNycWljQXNoYU4xeHhJMUwxK1E5QVlxWmNVRTlZMTFXTXRadFprYXkw?=
 =?utf-8?B?Rm15QjJwakxrWDNObVh2L0VrbmxKWUtMVHRQR3dZdkpuc1hMaTVxdFBzUG5R?=
 =?utf-8?B?Tk9VKzFDRkVMQU5NWUZlNnFMWHBxd3NkWDVKMWpybEpCOU1MTXBSWXc1Njda?=
 =?utf-8?B?TC9yNnpqQlFlL09EdG1BVERVSTd4RzIydkY3RDh1MTBrMGZRaW1SYjhhcE9t?=
 =?utf-8?B?RXpFcUdtMUJtaGYzSG1oOFhMWGo0eG40NjZ0YVBnOEF4V2hMTFhDL1V1RmZ5?=
 =?utf-8?B?akhKYk9XL1loRWZsaDB5M3VldktrWkQ2WVJWRmpMc1pkTEw5cGZUTHNzMllZ?=
 =?utf-8?Q?SOGQWY7SSOv1x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk8reVQ1dlJBSXVQZXdhZEZOWlQ1bkZyNHR0c2pmbmdrc0NmdkVUU3E3YXhF?=
 =?utf-8?B?WEJieEVOWVg4WkpjeHlzemJzN1NYWEhzdFVpQ3FoOUdaamNGK1dXR1V1UUY3?=
 =?utf-8?B?cDZaSHhDQmRrQzE1S0lvOFVoK1JKK0RXZTlLWXRVdlBoUlBCTkhUVEFDdGNw?=
 =?utf-8?B?Yk44WG5TYjZ6bEk0K3hxcGdrMlljdFBnUVo0VDNmT1N3UW5ON1I2UTRyMURI?=
 =?utf-8?B?THE0cFVBd1loOEFlUVZnOUtTRWVUSCtrQVVHdkRWQ2RzOVlaUTd2R3pzV0lv?=
 =?utf-8?B?bmpSOXpoQXlVUFgzVWpzbDRSdVczNWVRNHQxbm43aThpY29uQkxlVnVMejly?=
 =?utf-8?B?TjVSVW1ZMWFybEhrK2VuVjBTaXFQam9WQjk0UVpHZDk4WEpuQ25TZEdEbzRO?=
 =?utf-8?B?azMzNnNScVhqd3ExZ2xvTFJVRmZYQ1VBOHRENy91RDJSUFR2QjhmbS9ocVJ2?=
 =?utf-8?B?ZGlRYkV2MDFxRnNZcy9uNEhPekNnZmpyZGlQNk9BS09GZWNDTEpiT3VoSUt3?=
 =?utf-8?B?RWFmQ29sMWFuaU1GMmEzT21GbjBxQXJTdHk5QzlocXZYZ3RVejY5L05Zditv?=
 =?utf-8?B?ZDdzRVIvUmhmc3RoSkMxZUpEcEVkc1RxUGdQNGpEdjJKYUlnQ2tBK1Jkdlc0?=
 =?utf-8?B?dXM4WjVxVUFHMVF0bW5KRFgzWnV2UFY2UHZUTTEwS2MzUWk2U2pKSEJnWTVM?=
 =?utf-8?B?N1g4Z0h5Z2N1MG80S3IwUjBMZ3RVLzBVMzU2SDRDUG5ncmxPTko2NGdaSWQz?=
 =?utf-8?B?WU5QUlJ0ejVaKzFwaUo0YUMyeXk2aE52Y3ZXRnR2TXdZNTJucnJxRURJSHlr?=
 =?utf-8?B?elEwb2FvR0g0ak0wWnprdFc5TzVDTHYvaVNqbXNsQTJOcXVKSnBnMTNxK0VK?=
 =?utf-8?B?Z2Z3eGczZ1o5bm9JQkJpUGczS0c1ZEg2alRjZnd3UEsrNmE1a2Q0RExmUjRM?=
 =?utf-8?B?YjBnRlNnSmdMNWFVcnlsOThRT3JsOVR2czJlLzRMSXA2WWZ3VUNFVGZNWGZQ?=
 =?utf-8?B?N05RN3BDSXNPV1dQbW82bzdaVFZUN3plSkFsVkZielNtN3o4c1JOM08yYTk2?=
 =?utf-8?B?SmxDQnFhUkY5SUs5MVp2Nys1RjR0eWRxaDRGaitQeCtrOWVNWVFmWnk0Tk01?=
 =?utf-8?B?SEhwWXJMVUt2WFhpMkJXUTR2TVNZMTlkbG5JekJrNFQ4KzdzZ2JvVU14ZlB6?=
 =?utf-8?B?WTdBUUVzamU4NEk1NDE5VUlDWFVMTThhL25xcG0rL2pjK01KVVJadFJqaTNj?=
 =?utf-8?B?M0ZQSXMzRHBiL3ZXLzc0R0FMenhWMDVtUk0vbmVaUXFvN3pvd1hPL2ZsVGR6?=
 =?utf-8?B?UFNGMkloa1JzaitPejVxY0RBb0ZWMnVNUkZxeXpYc3JyK1I0Tld0SnlObFh1?=
 =?utf-8?B?aFBVQk9hLzIzeDBaTW0yYXBPNEs3K3lvblRERnVaZjdJVkwyWldJSGZaL21a?=
 =?utf-8?B?c203VzJ0WGppSzdpWU1VWW1VOEh4TGlFYXdQZ3JVSWNyMW80U1VJdkZkSFRD?=
 =?utf-8?B?Y0pld2RDZlZxNU5ydTJ6dkVaN28vblVBK0VNQ0NHWjVwNXpSRVg4SzlKU3du?=
 =?utf-8?B?TzRGc0VxQzAxUlR0SE9QWU9sS01kVDkwKzNCOVB4cERodld2bVd4cnU4cWlm?=
 =?utf-8?B?d1pVMk5hU3JjcTlsQWdEd0dLcDZFSW04MVJnREthdlR3SWlOMXgvVjJ3Qy9L?=
 =?utf-8?B?Nk8wdTdLeWNlMUFDclJxNnpoWmdJZlp5SFdyU0RIemtmSHBSOFlJVm9taHpT?=
 =?utf-8?B?enFKZU1ROFRXeXJaNVZ3bzJ4Z0I4LzVSNFRHWU4rSXdEOXhXQTRGRTU4c2ZN?=
 =?utf-8?B?T1NnbTY2NUJMZ05RWkRTS0R6VURTTnNYSEJjS3Y2T29ISWpieXRDN2h6NVAx?=
 =?utf-8?B?VytJMUVaZmFiRnFnV2Myb1BGb2gwRkI5VnZIMFpSY3FqUEF2WVBFV0lHRVJJ?=
 =?utf-8?B?bmJ0d2tuZ1NQZEI2TUx3YTIxZTdERWgya294SUVXNUJ2K3lqK2p0LzFYMmlw?=
 =?utf-8?B?SGx1RVU2WUhHa1BTbzQzOFJ3Smt4bzFnU1JyQTcyeFpCM2dqamJiZGJmNHZ6?=
 =?utf-8?B?SFdmMDQvWFp2bGZNbkVuSWd5VHVOS0krMmJvU29PUnpMa2Fuc29uTkJDajZ5?=
 =?utf-8?Q?/C0tb5hzcjLU6lM0UwNhpOeQ0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4111b1ca-e898-4028-28bd-08dd2ecda415
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:44:51.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CelZs1rLctkjAsUwPwRaEWu35EVMZNXWVsVNEWvpiGkQLMu5aADYigYXbW0uqBYZ67pRIFf82ypOVrIzEVZjOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

DEVMAP PTEs are no longer required to support ZONE_DEVICE so remove
them.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig                    |  1 -
 arch/riscv/include/asm/pgtable-64.h   | 20 --------------------
 arch/riscv/include/asm/pgtable-bits.h |  1 -
 arch/riscv/include/asm/pgtable.h      | 17 -----------------
 4 files changed, 39 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7d57186..c285250 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -43,7 +43,6 @@ config RISCV
 	select ARCH_HAS_PMEM_API
 	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
-	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 0897dd9..8c36a88 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -398,24 +398,4 @@ static inline struct page *pgd_page(pgd_t pgd)
 #define p4d_offset p4d_offset
 p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline int pte_devmap(pte_t pte);
-static inline pte_t pmd_pte(pmd_t pmd);
-
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return pte_devmap(pmd_pte(pmd));
-}
-
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
-#endif
-
 #endif /* _ASM_RISCV_PGTABLE_64_H */
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index a8f5205..179bd4a 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -19,7 +19,6 @@
 #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
 
 #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
-#define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
 #define _PAGE_TABLE     _PAGE_PRESENT
 
 /*
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index d4e99ee..9fa9d13 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -399,13 +399,6 @@ static inline int pte_special(pte_t pte)
 	return pte_val(pte) & _PAGE_SPECIAL;
 }
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pte_devmap(pte_t pte)
-{
-	return pte_val(pte) & _PAGE_DEVMAP;
-}
-#endif
-
 /* static inline pte_t pte_rdprotect(pte_t pte) */
 
 static inline pte_t pte_wrprotect(pte_t pte)
@@ -447,11 +440,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_DEVMAP);
-}
-
 static inline pte_t pte_mkhuge(pte_t pte)
 {
 	return pte;
@@ -763,11 +751,6 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
 	return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
 }
 
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
-}
-
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
 {
-- 
git-series 0.9.1

