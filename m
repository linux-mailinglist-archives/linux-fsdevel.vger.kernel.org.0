Return-Path: <linux-fsdevel+bounces-74184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB2CD338C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6C6C301AA80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFB5397AC5;
	Fri, 16 Jan 2026 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="BZLZ3kD7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020102.outbound.protection.outlook.com [52.101.193.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926739341A;
	Fri, 16 Jan 2026 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581738; cv=fail; b=bTKUvvpZa4Vbvqp2k7K3drac7f5Zm35tEVNHJUkcuYfxC6ljHTtHsyzibSH+Ufchx2wUyTMEiBNOW2XysenImEzGmeQMmh34tWNo735i5b4kIzMxfvjiSMUvUyPzEsroQSx+9EY6cAot7gfCDLvGert8cBY8S04c6aN0ZJz4luI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581738; c=relaxed/simple;
	bh=rfcPL2YpBzrVd6PMyaKBDdAkNtfol9KIk4KuhozgQg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nWawV1N/nASDF8TI4lrnFqOC/ynbzmBL3D1cJL8XPMHta2Ft92mvyxl2tc1SGYlitl552FGm83j6VPv/+kQUJz5/0tTeuvnH54qaMooFaO59NRdPes8jUUK5JFXeW5xmZXvk9YvcUlouDO5FKPzlHv5PyNRnzJ0wQWRbLyOq+2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=BZLZ3kD7; arc=fail smtp.client-ip=52.101.193.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFeacHB1VTgx4xdvWBXMTvi0P0myq3STc6g3QvoDTMNdLqgyI8pY0J0H+WMTWJh9VqlmASM4b/08eubZYCVe5nKjMEUar7Oqxnvg42MAh4eze1zM1vpuGFu5Ea0FmPYo8jS1JbXgfd5QfqxAvD8F+nGxvfDRhk02aF+hVSbIqkIYX8GwpBeMcS1nxVTsbIY2M3As7IToFtXUbu1czUGiOuiFKQJk0xlEvxsBygeyunEQ4T4/jFjOyNj7KJkznBaUkT4pfYdwQ9s0oWSBQLbdOQrHLwqQKKAhdC6fhZxrKI9OTr3/5k46vjEJWMvFZn9a1pcW39BTxDNmSR1lVihc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdwBJtCxj7pX/XsAerHwoD/vg7IZGzY6RFJimwYnSv8=;
 b=e0djprfI1zfM6rylCBrJxA2FQ7XZJyO7rrwVn2rzrGcBdWqrzmGBqLZSQMSqUTxmrhXiibC9H7/VeVmy4H2v9PXrL/LYXGBdE8/sGMti+K6rVOOVDV0+8NwDw233gjzKbK7Qqzrq55Sx4iTnvPRnFGj0mgIHrMfa7IXP4VhZ3PqSZfMHqsSz5Lr3ciO4/sUkQRhmS3mrWTdqGmaefvImxSdHcNVerI/or7Uq4LdOMjkxQXF5XOWebjQo5/D3zMu1APMiITEBuYHR5b15askiO9vBD5L5NQHRe0nti0vLL/DHkCphsiOBR0ADNYmqM2XzIVjiZ34/qDnSKealuCJk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdwBJtCxj7pX/XsAerHwoD/vg7IZGzY6RFJimwYnSv8=;
 b=BZLZ3kD73qOZuX1Z5JXxj8tk0b7KfNIAhsAq7+0Wmsf2qi+OtjmS3J6Sxgrut4fUNW0os4j0boEKWpZPwP4ln2JF6DS8NJEZDi1wl+MvWhnFuDYVmZetUTJBpSOoteaWiTTK+hEgGQ8UfjfslTGboq89zQExLnRllaoqb/40E+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 CH0PR13MB4603.namprd13.prod.outlook.com (2603:10b6:610:c3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.6; Fri, 16 Jan 2026 16:42:10 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 16:42:10 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 2/4] nfsd: Add a key for signing filehandles
Date: Fri, 16 Jan 2026 11:42:06 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <4A6213D5-BEFD-4090-9134-8D397C3F2ECE@hammerspace.com>
In-Reply-To: <bb62acdd-4185-41ed-8e91-001f96c78602@app.fastmail.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <c49d28aade36c044f0533d03b564ff65e00d9e05.1768573690.git.bcodding@hammerspace.com>
 <bb62acdd-4185-41ed-8e91-001f96c78602@app.fastmail.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|CH0PR13MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c56782-04a2-4741-d229-08de551e3191
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rnOS3EaTh2m8FiyG6LDszY1dFtkP+EERAS0rUn3wHMCEgbVS752NUIDqei9V?=
 =?us-ascii?Q?2ScOMvDEG8voJe0IMaaHH/FoDkYzn7NeZUjcVP26dH9r/OkRJ4fIJCtRdu4q?=
 =?us-ascii?Q?IrZwgvh2/hOR95BoHLMtwXDM2i7jsO1eCu37/4sN9V/oulBpO36AN/jaWWvb?=
 =?us-ascii?Q?XZL5V7sU8x468Ge4dBhG10E8/vGTFmikSuR3zZmYyiAScV615WEofUn4+Tu2?=
 =?us-ascii?Q?iZ1Hbvg/ukTK6K30rP+eOmHa49ItK95AP7a3BNgFrAKL5CbV9xZ+iKAYtXSR?=
 =?us-ascii?Q?7tT+4w7SXg2zRZd/ZDOvzK+/78DYUHNrS1W1gtHWNS8YKgqriuIbh1PVpFUZ?=
 =?us-ascii?Q?VS+ttqnox2NY0AYhVMQHN6uzeSkuYgrvrzcbWIA2UGNff9kkkdovX7NMcsE3?=
 =?us-ascii?Q?RTKZ+KL0NsrObfWbE2TcwMkLpFfBx9nGz9Gp2Faum9D17GJ9TnVaGrYQI67m?=
 =?us-ascii?Q?AyiyJuEZYBZUdWatHQArGSgLxffeuZmwWNuGOUuXF+D73fpVlQ87uKnQ8fTN?=
 =?us-ascii?Q?hYbbVyfXEuw1dChcF5WpZC4GkonI2yMxBCFP2ILhar3qIwyTLmuhBiZNRC94?=
 =?us-ascii?Q?SDbiFC5fXndS+sCuFDRc+hhKq8XF8MCPkm/0QqAZt8RJS6EuG1ay0KzDB2Fw?=
 =?us-ascii?Q?J7slqZff2kB0AIMCXgrxRVeWLZVX6zOrwvfAKJH+/DnI17qupPSN2m7XDRJo?=
 =?us-ascii?Q?Pu73lg9guvQNbSBqir1DNE1lELVJ8iCJ6wQ/Dr9KRM9oXu/KXmbOCIh5R5jW?=
 =?us-ascii?Q?/SB610Q3ySAFrgabaVJCHxyVSvyLymlZ8i/dfPgoOnOvS7mj+OCi3FTeQ/Qn?=
 =?us-ascii?Q?dVZVoCrX+pBcYGqcXK5fs8CLXOM2K0lUAm+JHTqLi9jgy+xTOw//DoJaSPtt?=
 =?us-ascii?Q?DDmk0n+qT5QZbMtPt6A+eGvIeEQvVEP61+DkHhLL2THsUcoaZS5IWGmdnQ69?=
 =?us-ascii?Q?BJerTNlN3xUPH3UCDzSCKNffOeg1VipgJs3toUs4jSh0+mr625UYgNpDWxyR?=
 =?us-ascii?Q?No4JY4uMYGeZgZjekjpOeWMvCqRLSM51iZYEfIwvH8yc80i2i4+/+Qm8T6t1?=
 =?us-ascii?Q?thJAi2cF4hzhp4NvsbnG6h7PU7x2UQ7rvQHJYT7JlKLz+6NKxMfJ0XJa4/S+?=
 =?us-ascii?Q?o6e9rDTsdHi/Ms6dBvFA1gZAWFjWICnStQZXH5q+gpOZDpbO6c/wVThlME9I?=
 =?us-ascii?Q?xRkGOgG1EbQRiAdP99k6SWC8G9KGkADjQ1iHqlA8nYBwpx6iV7BVtUB1m3Ol?=
 =?us-ascii?Q?Qy67zmvC6NP5cwGYDhvf5kG3ouB3IzGCz58CPFVYBFSxKYHcygu/bDyJT5FG?=
 =?us-ascii?Q?vFHeroJioYzWx5L1HOU0oS35gy3CGY78+q9mS6OIXziN/PZxWZRsOT7HxL+d?=
 =?us-ascii?Q?+8xxOidkNXiWevfmDuL1zkgoJiq+VwCkpO4AqWFM2N8e1MGeFeBy7Qeiu27J?=
 =?us-ascii?Q?9I+37JA69B3/xlK3ZDa6tgHKRY1IFs/alb6v8DTcKMaC/sjBWrmuup5LkXBk?=
 =?us-ascii?Q?8MK6+Yntzvuajm6iTCMYefSK/UPkyxzoJ8ikTMZ899D2AXUOuJsNg8+bOEvr?=
 =?us-ascii?Q?3HhEU2/gzG7IG8J+kEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QAzrcee6d2j2098cUNEzpt5KSyv4F21kNlO8oS6ylSc6qFGquam3yYU7A2jn?=
 =?us-ascii?Q?jEfNLN6ymJh5r5e+EfAw/VvkW1Qtw8D/+p2jY3mH6aq6QSbT7lIBybzOleVn?=
 =?us-ascii?Q?R3IPjJ20cd4E56eWP/7Sws5yAIONX9jMHteoKCdXLbr/NzTuorpa9tEWlufk?=
 =?us-ascii?Q?EmzsvQnGvkbsZqH+h2wRr0S9hORpyr5OYL7AS3n/VJ/BfWltgajsCYPyuTEc?=
 =?us-ascii?Q?JlLOPtCkrlnJBpApI/SOOeuweyU0x23TyWL9fST606052GGWSmvT9YIG9QEk?=
 =?us-ascii?Q?0Tafj0u3lOR7xLRmoWOnGToui6GR8LeLEe7hnpd/zFAJInjK4Sh2A25Gyl3L?=
 =?us-ascii?Q?RPMMzLl4cXuJOTCxccFdXJOjLhalRb+Py1UIMwd5/5IQ1NOvurKupbedJ6zX?=
 =?us-ascii?Q?9bbwRqksFRENY1oPLEYDm0+Ko9T53GyZzZgdCrO5YFO6IsAcgu5dw05pcBw3?=
 =?us-ascii?Q?E1GaLn3wjAgfWP/Knw0bZx++swIks8Jilm8nY2fMv3dXbwp6GkPGy+42QXQT?=
 =?us-ascii?Q?/r1wz42ziQYWS8E9Kv8pRjt8XCBKJ3jjJXL7IwJKH+8ZYwmIczcEkIPVwMAL?=
 =?us-ascii?Q?0eOO6FO08qgFCU7vSLdlASJYUPq/SycQLzRA5/oyBu2k/CnW1Ch+fUHkbOBh?=
 =?us-ascii?Q?aiPQxDIbhWeFalKwOnkROltR5r5o4zh4eYB8LinrWzseOI611xOQiiXVMSBz?=
 =?us-ascii?Q?J5BfqEv1RlKXcDxq8YaUFhFOn0AG3C1WOjx7UGfO4478T7qDl9NRMDVLOOC3?=
 =?us-ascii?Q?VCZXDfGgLiqKTcapWUF6O7yPOzSS7R5FK8gR8ZDAMje5rCjgH+5J0InTZWgr?=
 =?us-ascii?Q?c58xGmYPT89rXAwTIOBi+UttPjghhpRpp3iZAatIYuoVvCLS80cVp8XzyGdx?=
 =?us-ascii?Q?KuCfp3CEb5F3wp+2wVyFhBn7u9ov0EZi3yo8Tkjrs71NSrCx6GNTiny2HkVu?=
 =?us-ascii?Q?IrDTKn3WxVlUWQvPL9iSK8RcCsbct7uEzr41mHGLmfdMk1+z6EDiC/iPtQgW?=
 =?us-ascii?Q?Gssv3eRiPCqXJvnZnxxn1VgF28uCwNLMlsnswuL1RHFi1EBZWe1bVZg/xlsl?=
 =?us-ascii?Q?cFUWyWTcg8otLCjX+Vatvv7saDLQb8H8IPZZH06/7tLIjDN+PKN6vS2Bnczj?=
 =?us-ascii?Q?zRu8J9ul34uIUphsuxLUlMk3NQKLgJkxvkfTNEeG7KQBNX5pujwbMN+D3JaY?=
 =?us-ascii?Q?COrKUx/xxswW8Oor6a5g9nMyXzqNnNWQDa6OzIDs7qDcUML+pl56GXl24QH2?=
 =?us-ascii?Q?FQp+bTo3+lCxaOWkwc7oeUSqO6ikUgYPZeVQtpWi4ktiG43XW7ISVT8b24wn?=
 =?us-ascii?Q?bo2LDax05xrLmSWLkHZybiZkFelXzS35S5nKmGR7g552TjOYu/KJO3rcnPwy?=
 =?us-ascii?Q?qQclQac7Nah8GOYtz2YeI78D0TXVhwcXv+VmGFEe+WJR0cvtYKi8bViwAExO?=
 =?us-ascii?Q?k2FataBF1p2nne6WG/P7TqbcNgSTZatWGzwrSp1Uo32Aw+e6oovb8FmDSYaS?=
 =?us-ascii?Q?TfxoVap4Hnj5Wu31RjxWZgzfWxWidrMhGCvefy0Qe8Qke0rtb0hr9RNdQip0?=
 =?us-ascii?Q?Xn7PUMGQCSHV0kA3U5vKgfBqRTT7LWd3AMQrEz3JS4f2Kuz0a8gOIhXey7/z?=
 =?us-ascii?Q?/YmYZHUffusWEtBtZqpNNnpmODYIA0SKy74q+kOW3HrAdEIad4DbzoTd0Hnk?=
 =?us-ascii?Q?bHx2GWM4B6gRl67mcmsthj2Y50kpEA+voucCzNAtoiSxrnJWrdhcioWnAVMw?=
 =?us-ascii?Q?omuY6tPkDADDDMR4vB1V76jCCx9qMik=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c56782-04a2-4741-d229-08de551e3191
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:42:10.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Gd/0z/dRsXMjz7t9yKnFin+eOAIoK4jeHc72CjGF2blpaWxGXwAIJsreNZ7g+2PFrtUJzop4IguSKBNrx9WyWwsccCNPaz8Qz0lF+Lb2eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4603

On 16 Jan 2026, at 11:11, Chuck Lever wrote:

> On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
>> Expand the nfsd_net to hold a siphash_key_t value "fh_key".
>>
>> Expand the netlink server interface to allow the setting of the 128-bit
>> fh_key value to be used as a signing key for filehandles.
>>
>> Add a file to the nfsd filesystem to set and read the 128-bit key,
>> formatted as a uuid.
>
> Generally I like to see more "why" in the commit message. This
> message just repeats what the diff says.
>
> Since the actual rationale will be lengthy, I would say this is
> one of those rare occasions when including a Link: tag that refers
> the reader to the cover letter in the lore archive might be helpful.

I'll add a bit more context, and the link.

>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>>  Documentation/netlink/specs/nfsd.yaml | 12 ++++
>>  fs/nfsd/netlink.c                     | 15 +++++
>>  fs/nfsd/netlink.h                     |  1 +
>>  fs/nfsd/netns.h                       |  2 +
>>  fs/nfsd/nfsctl.c                      | 85 +++++++++++++++++++++++++++
>>  fs/nfsd/trace.h                       | 19 ++++++
>>  include/uapi/linux/nfsd_netlink.h     |  2 +
>>  7 files changed, 136 insertions(+)
>>
>> diff --git a/Documentation/netlink/specs/nfsd.yaml
>> b/Documentation/netlink/specs/nfsd.yaml
>> index badb2fe57c98..a467888cfa62 100644
>> --- a/Documentation/netlink/specs/nfsd.yaml
>> +++ b/Documentation/netlink/specs/nfsd.yaml
>> @@ -81,6 +81,9 @@ attribute-sets:
>>        -
>>          name: min-threads
>>          type: u32
>> +      -
>> +        name: fh-key
>> +        type: binary
>>    -
>>      name: version
>>      attributes:
>> @@ -227,3 +230,12 @@ operations:
>>            attributes:
>>              - mode
>>              - npools
>> +    -
>> +      name: fh-key-set
>> +      doc: set encryption key for filehandles
>
> Nit: "set signing key for filehandles"

Got it - there's encryption artifacts in 4/4 too..

>> +      attribute-set: server
>> +      flags: [admin-perm]
>> +      do:
>> +        request:
>> +          attributes:
>> +            - fh-key
>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>> index 887525964451..98100ee4bcd6 100644
>> --- a/fs/nfsd/netlink.c
>> +++ b/fs/nfsd/netlink.c
>> @@ -47,6 +47,14 @@ static const struct nla_policy
>> nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
>>  	[NFSD_A_POOL_MODE_MODE] = { .type = NLA_NUL_STRING, },
>>  };
>>
>> +/* NFSD_CMD_FH_KEY_SET - do */
>> +static const struct nla_policy
>> nfsd_fh_key_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] = {
>> +	[NFSD_A_SERVER_FH_KEY] = {
>> +		.type = NLA_BINARY,
>> +		.len = 16
>> +	},
>> +};
>> +
>>  /* Ops table for nfsd */
>>  static const struct genl_split_ops nfsd_nl_ops[] = {
>>  	{
>> @@ -102,6 +110,13 @@ static const struct genl_split_ops nfsd_nl_ops[] =
>> {
>>  		.doit	= nfsd_nl_pool_mode_get_doit,
>>  		.flags	= GENL_CMD_CAP_DO,
>>  	},
>> +	{
>> +		.cmd		= NFSD_CMD_FH_KEY_SET,
>> +		.doit		= nfsd_nl_fh_key_set_doit,
>> +		.policy		= nfsd_fh_key_set_nl_policy,
>> +		.maxattr	= NFSD_A_SERVER_FH_KEY,
>> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> +	},
>>  };
>>
>>  struct genl_family nfsd_nl_family __ro_after_init = {
>> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
>> index 478117ff6b8c..84d578d628e8 100644
>> --- a/fs/nfsd/netlink.h
>> +++ b/fs/nfsd/netlink.h
>> @@ -26,6 +26,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb,
>> struct genl_info *info);
>>  int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info
>> *info);
>>  int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info
>> *info);
>>  int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info
>> *info);
>> +int nfsd_nl_fh_key_set_doit(struct sk_buff *skb, struct genl_info
>> *info);
>>
>>  extern struct genl_family nfsd_nl_family;
>>
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index 9fa600602658..c8ed733240a0 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -16,6 +16,7 @@
>>  #include <linux/percpu-refcount.h>
>>  #include <linux/siphash.h>
>>  #include <linux/sunrpc/stats.h>
>> +#include <linux/siphash.h>
>>
>>  /* Hash tables for nfs4_clientid state */
>>  #define CLIENT_HASH_BITS                 4
>> @@ -224,6 +225,7 @@ struct nfsd_net {
>>  	spinlock_t              local_clients_lock;
>>  	struct list_head	local_clients;
>>  #endif
>> +	siphash_key_t		*fh_key;
>>  };
>>
>>  /* Simple check to find out if a given net was properly initialized */
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index 8ccc65bb09fd..aabd66468413 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/module.h>
>>  #include <linux/fsnotify.h>
>>  #include <linux/nfslocalio.h>
>> +#include <crypto/skcipher.h>
>>
>>  #include "idmap.h"
>>  #include "nfsd.h"
>> @@ -49,6 +50,7 @@ enum {
>>  	NFSD_Ports,
>>  	NFSD_MaxBlkSize,
>>  	NFSD_MinThreads,
>> +	NFSD_Fh_Key,
>>  	NFSD_Filecache,
>>  	NFSD_Leasetime,
>>  	NFSD_Gracetime,
>> @@ -69,6 +71,7 @@ static ssize_t write_versions(struct file *file, char
>> *buf, size_t size);
>>  static ssize_t write_ports(struct file *file, char *buf, size_t size);
>>  static ssize_t write_maxblksize(struct file *file, char *buf, size_t
>> size);
>>  static ssize_t write_minthreads(struct file *file, char *buf, size_t
>> size);
>> +static ssize_t write_fh_key(struct file *file, char *buf, size_t size);
>>  #ifdef CONFIG_NFSD_V4
>>  static ssize_t write_leasetime(struct file *file, char *buf, size_t
>> size);
>>  static ssize_t write_gracetime(struct file *file, char *buf, size_t
>> size);
>> @@ -88,6 +91,7 @@ static ssize_t (*const write_op[])(struct file *,
>> char *, size_t) = {
>>  	[NFSD_Ports] = write_ports,
>>  	[NFSD_MaxBlkSize] = write_maxblksize,
>>  	[NFSD_MinThreads] = write_minthreads,
>> +	[NFSD_Fh_Key] = write_fh_key,
>>  #ifdef CONFIG_NFSD_V4
>>  	[NFSD_Leasetime] = write_leasetime,
>>  	[NFSD_Gracetime] = write_gracetime,
>> @@ -950,6 +954,54 @@ static ssize_t write_minthreads(struct file *file,
>> char *buf, size_t size)
>>  	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);
>>  }
>>
>> +/*
>> + * write_fh_key - Set or report the current NFS filehandle key
>> + *
>> + * Input:
>> + *			buf:		ignored
>> + *			size:		zero
>> + * OR
>> + *
>> + * Input:
>> + *			buf:		C string containing a parseable UUID
>> + *			size:		non-zero length of C string in @buf
>> + * Output:
>> + *	On success:	passed-in buffer filled with '\n'-terminated C string
>> + *			containing the standard UUID format of the server's fh_key
>> + *			return code is the size in bytes of the string
>> + *	On error:	return code is zero or a negative errno value
>
> Nit: it would be nice to explain (briefly) why fh_key rotation during
> server operation is prohibited.

Ok, will do.

>> + */
>> +static ssize_t write_fh_key(struct file *file, char *buf, size_t size)
>> +{
>> +	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
>> +
>> +	if (size > 35 && size < 38) {
>> +		siphash_key_t *sip_fh_key;
>> +		uuid_t uuid_fh_key;
>> +		int ret;
>> +
>> +		/* Is the key already set? */
>> +		if (nn->fh_key)
>> +			return -EEXIST;
>> +
>> +		ret = uuid_parse(buf, &uuid_fh_key);
>> +		if (ret)
>> +			return ret;
>> +
>> +		sip_fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
>> +		if (!sip_fh_key)
>> +			return -ENOMEM;
>> +
>> +		memcpy(sip_fh_key, &uuid_fh_key, sizeof(siphash_key_t));
>
> What protects updates of nn->fh_key from concurrent writers?

Just the check of the null pointer -- but looks like I forgot to check
it here.  It has a TOCTOU anyway, so yes needs and will add the mutex.

> A race might result in leaking a previous fh_key buffer, when
> it should return EEXIST. So you'll need some mutual exclusion
> here -- probably nfsd_mutex.
>
> Ditto for the netlink interface.

Ditto ack.

>> +		nn->fh_key = sip_fh_key;
>> +
>> +		trace_nfsd_ctl_fh_key_set((const char *)sip_fh_key, ret);
>> +	}
>> +
>
> If user space reads the key before it has been set, would
> nn->fh_key be NULL here?

Yes, but scnprintf is smart enough to print "(null)"

>> +	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%pUb\n",
>> +							nn->fh_key);
>> +}
>> +
>>  #ifdef CONFIG_NFSD_V4
>>  static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t
>> size,
>>  				  time64_t *time, struct nfsd_net *nn)
>> @@ -1343,6 +1395,7 @@ static int nfsd_fill_super(struct super_block
>> *sb, struct fs_context *fc)
>>  		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
>>  		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops,
>> S_IWUSR|S_IRUGO},
>>  		[NFSD_MinThreads] = {"min_threads", &transaction_ops,
>> S_IWUSR|S_IRUGO},
>> +		[NFSD_Fh_Key] = {"fh_key", &transaction_ops, S_IWUSR|S_IRUSR},
>>  		[NFSD_Filecache] = {"filecache", &nfsd_file_cache_stats_fops,
>> S_IRUGO},
>>  #ifdef CONFIG_NFSD_V4
>>  		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops,
>> S_IWUSR|S_IRUSR},
>> @@ -2199,6 +2252,37 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff
>> *skb, struct genl_info *info)
>>  	return err;
>>  }
>>
>> +int nfsd_nl_fh_key_set_doit(struct sk_buff *skb, struct genl_info
>> *info)
>> +{
>> +	siphash_key_t *fh_key;
>> +	struct nfsd_net *nn;
>> +	int fh_key_len;
>> +	int ret;
>> +
>> +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_FH_KEY))
>> +		return -EINVAL;
>> +
>> +	fh_key_len = nla_len(info->attrs[NFSD_A_SERVER_FH_KEY]);
>> +	if (fh_key_len != sizeof(siphash_key_t))
>> +		return -EINVAL;
>> +
>> +	/* Is the key already set? */
>> +	nn = net_generic(genl_info_net(info), nfsd_net_id);
>> +	if (nn->fh_key)
>> +		return -EEXIST;
>> +
>> +	fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
>> +	if (!fh_key)
>> +		return -ENOMEM;
>> +
>> +	memcpy(fh_key, nla_data(info->attrs[NFSD_A_SERVER_FH_KEY]),
>> sizeof(siphash_key_t));
>> +	nn = net_generic(genl_info_net(info), nfsd_net_id);
>> +	nn->fh_key = fh_key;
>> +
>
> On success, "ret" hasn't been initialized. And maybe you want
> the error flows above to exit through here to get those return
> codes captured by the trace point.

Gah, thanks!


>
>> +	trace_nfsd_ctl_fh_key_set((const char *)fh_key, ret);
>> +	return ret;
>> +}
>> +
>>  /**
>>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>>   * @net: a freshly-created network namespace
>> @@ -2284,6 +2368,7 @@ static __net_exit void nfsd_net_exit(struct net
>> *net)
>>  {
>>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>
>
> To save an extra pointer dereference on the hotter paths, maybe
> fh_key should be the actual key rather than a pointer. You can
> use kfree_sensitive() when freeing the whole struct nfsd_net, or
> just memset the fh_key field before freeing nfsd_net.
>
> Just a random thought.

Could do!  ..but its easier to check if a pointer is NULL than to check two
u64's being unset.  That said, having half the key be zero is probably
insane odds.  I also figured to minimize the size of nfsd_net when this is
not used.  I think I like the pointer better, if that's acceptable.

Thank you for your review here.

Ben

