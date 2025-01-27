Return-Path: <linux-fsdevel+bounces-40165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BB9A20084
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC257A2604
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 22:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC1F1946C3;
	Mon, 27 Jan 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fYzbkDxD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2034.outbound.protection.outlook.com [40.92.91.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0D1D935C;
	Mon, 27 Jan 2025 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738016602; cv=fail; b=AY4y3afnHa2t57Q2jzjSZx6MafJ4KNgO2YU3DBCr0TjAtNsM5QP6TKMP1ec+iEjOTgTVwrW8HyAPAVXN/nAHczVeynB+CO4gNqgxLgu4c1D6/Q+BL8PK4VnCoxysepttZ4iKsSvcqTQR7Uatz93RDR0ZQfn3pAqHC5WZNXSbPWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738016602; c=relaxed/simple;
	bh=uPqR0voVaLzyt9XDEUZPgXhYbWBZx64ulHHfy/cgT2g=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AhdyQVUgcM8L92em58wT1VT/PSrBkBW+VBzoE4vtyoPOxBTf+hZx89hE2299OQch0yYabzAEhyjBlRWxjl9bbM1Q+TRXpdHrfXqpqEm8ggbzfrfWD1DTUsQ8hpus6o3cqTdgJGd4+K3h7UGai7MroKJ2RVpR7iVB1AXLGrQqxyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fYzbkDxD; arc=fail smtp.client-ip=40.92.91.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWSSFKV765OvJgWw4TPs0IYN1kLS6VroBVjFRZWD8imrCALyevXfQAnzqL327ADICL//PVD2AIgSXQN4X6TOW3gmD51qdBrrb59lpbyb+J1HsgVz/QMYPyoKqYueMMMybkISuHA3UNyFEG/L9S8sug7XWRtE1hSU7NnX+rMGz//yEC2+r3l9Ul/vU6XzkmBTzdNk0dUA0uPQOoZkTFjBXjgzaLzoKomgryih3VhFnKSbrmlHBRV0NB70NRvPvWzu/tWW5x+gzJrrzLogphKlcbuaCCzS0mnfpJ6QQdnLQdrQl7vQweXQ93bZhzh6sX1t4eOKOAWOemHiz4Yr5vR+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQRAc4asF61PEtcdx1z1TaVfhwPSV85pvIczokIfF/Y=;
 b=P3KFjvpLibpXLTu7lDtbVbqte2zdwOLFp3MH8K6aMlKRKx+PIKQudO3zUXexqdLkXyl1bsUNgCzmTdimPhvMh6ChzN7yc3bSFUuocZL307B+Z/SU7dT26qYltNMJbkXuuS0cgTX8sJ1R7ScawY8suuvwlHUukNZf3cPod49FNv6h05uenQYl3fiDWt/9xjsjilYEqllNEH1IwxW3YlhuSTupjsFNyK+ns0IllZ1wsSZKKY48IaM+TwMB/HLOgAKqisznfskurN8kHnkOmJ6atoJcmQgoS1gaI+IMouR0jxDVIKzugYeGmBLt/pmT2W8+aMGSkn2wyrp0SpcC39FU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQRAc4asF61PEtcdx1z1TaVfhwPSV85pvIczokIfF/Y=;
 b=fYzbkDxD16gVScXmljnlhj0OENw0jsjI58MTN/+VpxNWvzAfeqzkTLx4bh3bTt2Yn8/HSEACXHxF2DEtaDBgKfov+bC8SXbL8xdBgAzdquu0WHYv/SGbEK8//hivhVmNoi3n+XFUqdGYNiKm4QGnPi7yaP+J95M0o3ZLP3OkyKktt4dNmTR9qBJYdLR988UGfkcXKfgjnf3CHBTy+q/BpdVqpW3xJQ8NdG+E7qQgFe8x988ARgWa+smvmNnQ8SFowxWVAwIZDvT2SdnK0Y3P23o0hGIIRsSsFN2ZAvU5uUsJv7MtyopUsxdnigZ7jmciLICdjzRh91A8PwkUsDU6NQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM9PR03MB7833.eurprd03.prod.outlook.com (2603:10a6:20b:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Mon, 27 Jan
 2025 22:23:17 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 22:23:17 +0000
Message-ID:
 <AM6PR03MB5080DFE11B733C9DCD6547E199EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Mon, 27 Jan 2025 22:23:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 0/5] bpf: Add open-coded style process file
 iterator and bpf_fget_task() kfunc
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB50806D2E13B3C81B0ECDB5B299E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <AM6PR03MB50806D2E13B3C81B0ECDB5B299E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0507.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <cf55e5cb-1fa1-4bd8-a7f0-c00cc8512cc3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM9PR03MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: caf3c10e-4a63-4e2f-6df8-08dd3f212f8e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799003|5072599009|8060799006|15080799006|461199028|440099028|3412199025|56899033;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UllOM1g1QitERHJ3dnRqdmpqUWxzekp0ZldwcHVmbGlrVEFySUxoeHpNT2ZE?=
 =?utf-8?B?NG9jaXR1bi9zU0FNRGlMSG1saGxsR25tU1FaVGpGcGZIaEptYVBKRThzcElv?=
 =?utf-8?B?R0d4NTc0KzMvcFRxSk1kRkpWTDVDaFBuTjV5WEhsOWN3enN4WXNOZXpqa2h0?=
 =?utf-8?B?cUx0MnRRRkwyS0FKbUgxQnhDTS9CZzZoOHhmVHlpQ1Q4ZGxnTTRjTzlCS2dP?=
 =?utf-8?B?OG82SkRzcndkeVlNbUQrbDRnb1llQTZSYXBGRlQrYS9FRUU1bmVTK3l1T1Ra?=
 =?utf-8?B?ZTI2Rkd2MHo2dnJmK0xnN2hXZXNFVjlTUUtVSEhLbmhvanh6WGliak1nNXhY?=
 =?utf-8?B?R0cxZWhMMjdhR1JkSERvUWJ5VnZ0UmtPSi9DSDk0UTNzYVpZVGRFNHFvQ0lM?=
 =?utf-8?B?clRXU2I0TEdXQnVHQUd3WS9yc0ZFSko4bmt4Mm5mamovODY1VWlqQmJkNWFB?=
 =?utf-8?B?dE94SC9Bd0t0SFpaT25WY3VZQnNZWWxFOEx3dWdUazVYbjlaSVJJTUlXckZL?=
 =?utf-8?B?SlF2dk9hMEFxS0VTZWF5M29rSSsvMk1mdXJRRFhEYkxjSElSZDh4M1JXVFl3?=
 =?utf-8?B?U2VXNkorS2VISVdHaFdtTUg0VTA5VFdHeGFCUWJ3d0xwMEZudXVBNUNrSGpB?=
 =?utf-8?B?eUkxblFnUC9pVUEzcnRmZ3lrclFyM1JIRUR0bVlXdk5RZEIxOVpLWEdyU1Ay?=
 =?utf-8?B?VUJ4ZCtVTFFCT3B2UE12UVFjNVg0blBZVDRweXFVSEFmUWtzQzdLSThCVG5M?=
 =?utf-8?B?bkZLcHNxcjJhNEZwbkZSWDdHeGJ3L09RVllpOW5UVDF4SWFkWEJETEc4QVlk?=
 =?utf-8?B?UG5rQjVnUW5sUDF4NDhGVUZGbEtXOXJBN1dkaWt1REowM2VyVG5Db2xyQ0RT?=
 =?utf-8?B?Wk5ESjU5cy92M3FlT3l0T3pmMU1jQTVSb1d1OTFZemIzd1d5ZGFuaUdkOEJD?=
 =?utf-8?B?NUx2SjdOejQ5azhhSXFROERoeWcrYVNidmxnYWlkZGU2LzU4eCtMMFRUdWdm?=
 =?utf-8?B?cEoxOFZpaVZoYldkbjlNa01WczJMSHBXU1dQNlh1RmFaNk51ZGhaL2tpUml1?=
 =?utf-8?B?YXladnVsR0hoNHdIZ2NaaVp4ejFVM2kyU29ZRFpvS0wxc21xMlFMT28zVk96?=
 =?utf-8?B?SFV5WXIrUnA0ZHg2Zk5YSEhzTUNVZjFoVld0ZUhHM0NrV2ZCdGltbWdKU2xE?=
 =?utf-8?B?UzVGdXdZMEJDUTQvdkJHVEJFOUVvdkxURytUVGIvcWdlQTBMYVlBRlZKcEhs?=
 =?utf-8?B?eDQ2dkhkMU5FaWUwbmJRelFkMlNMam4rMDJBZFdwcFVRSnJwTzlhd3ZxZEdv?=
 =?utf-8?B?MU45VkxuTEcwSmtENFVoRmRLaUI3M0t5WVlFOHRtK3JOTGNHWFVMVVVxVExW?=
 =?utf-8?B?QTVscmpWVjhkZERwRC9MdFlHcjI2Mjl1dzgrYXBVbkwrSCt6R0xMOXg0TVFW?=
 =?utf-8?Q?QE7+ZoBB?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eC9yRURFMVB2SmVPRXAzR0w0eUZBRDlKdi8wS2djN2xWV1gyZUk3NEdlMHpD?=
 =?utf-8?B?bzNoZjkzblBSems0a2o4Qkc0cytsdzdEejlCc0lremFnaStqMXlLN29jQWs5?=
 =?utf-8?B?RUVPMVorSkoveWxQTVRGaDJtRkxnWHpJZVpyY3BoSGVUTk5oS2luUTJFeG1F?=
 =?utf-8?B?TGtGZHV4S0JIWmp0S2twT1VlOW5rbktNNVIwYWNyMXUwNG1yZGNXZlRDMW44?=
 =?utf-8?B?N0NveWlJZmgvY1Izb08yMDdLVzhiaDhwRGZJR0M0ZUNKTHIvQm03WHpmb1cr?=
 =?utf-8?B?MHFrcG56YmFIc1dTaXMwcDB6YW9TSlZsc2hEQTMraThHaFFHOVdlNHFKMmtk?=
 =?utf-8?B?YTRVRlk4eG8rbEV0YWtsait2eThDL2FFd1NNU0hEajBOMHkwOXFOa0haNEly?=
 =?utf-8?B?SXNMZlRPRkdrRE1laXh4ZGNxV1RpU0VwNjVIMmdMeXdmdm0rMjZDUlJKa1BO?=
 =?utf-8?B?UEpmbDlVVGgvRVlEN0NLRzVBVnRMRm0wZm1iVC9LM2w3RFVWVUZxd2hCcDUz?=
 =?utf-8?B?MU80TUIzSVdnUGdUQy9TOHlmdStWTG9tSmxNOXFqOUZ4KzVzWEdaUFdDSHRY?=
 =?utf-8?B?UnlQQ3RFOUNNNHpvRDdvdlhJdkNwazBpZlJmbHRWSUR4UlJTekwrREpWSDVq?=
 =?utf-8?B?NDV3dkY2S0kzcmVWb1BJNURNVWdlTVI0amkwQURRSWJrbzJWSzJ1ajN4OW1X?=
 =?utf-8?B?c05BT0xlM3luaEdGL05LanVaWmxKdkp4cFA5c3hNNXcyNzVhdncycVE5djVo?=
 =?utf-8?B?WFJzWUNqQzdoakNKOGJJMFFVWHJhM2ZVaGFPNDRFcXdXbWpTSWRKZm1Tckdu?=
 =?utf-8?B?c1NoRjErcnNIY3BrNUsrMjQ5b1h6SVBNUENaa1JDRGRCOVJ3dVRrbWRuclBp?=
 =?utf-8?B?dFJtY3ZkL3lWRUV6QWtrUFZ2MGNXWG9YZ2k5WVR1dFRYMlhZTGdvR01wUEcx?=
 =?utf-8?B?eVhnR0pGelJzclJiWVh1WjlibEFxQm5VdFlUV0Q5T0RSejhHTGVnNk1UN0lI?=
 =?utf-8?B?cWZIZENDdXRmZXZFS2RhQTArTGVLbGE3cW5NQmlYOUQzWnpveGlaakcwVWx6?=
 =?utf-8?B?dU9RK0xUTlMwNzNyOTJ5QXRXWjkrTzVHNjRFMzlmV2RDRmdsenJNbjdjUllq?=
 =?utf-8?B?NXc2VEZMZk9GcXdEQkQzWU1KUk5EdU5aazd1T1AvN2UzeEphYndCV25LQnhH?=
 =?utf-8?B?WTU3T2h4ak9ZRTQ2bm1FdUFoZWpOUXd1d1U1YkQrVFhESjJkZFp6eDNCV1A0?=
 =?utf-8?B?anNxUkpZZTRwT2orWkpYVHZvS0ViNG91VzQraVJ4N0RiT3BiVGVHeFpXYjlB?=
 =?utf-8?B?MHN0ZlhoaVUxUXprZXJpcmFaRE1rTFZ3eFR6UHVwMDA0aUZ1UUFoazV6aytx?=
 =?utf-8?B?aG1PVWVNcVlhQWlOdDNLd0tkdnBpVmQ3K3E0SnlFY0tseU9pRyt0ZGMzeHQy?=
 =?utf-8?B?emc1MHBDeVI5eGlkbEJHd0FWaUJ2Q3dVNzRmMGw4UXN2STgzUElVam94aFV1?=
 =?utf-8?B?Q1JCU2NERUEzbGxaV1dQUEUrZnRFVGppTUZRSzhoTjB1RmZ1aEtEcFkva2dP?=
 =?utf-8?B?MzNVN0FLYmJjdVNVNU1oMG1KQldjSFhKV1FXbGUwT0cvSnhIYzdJZzhQbU9R?=
 =?utf-8?B?VFRrcHJtQlJ6NUZxeXVGZGthbSt4MWN3Yk5lQUxBTmY5alpKcDh0aHI2cFZT?=
 =?utf-8?Q?hlCygaqTgDvgcLy2ZcG/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf3c10e-4a63-4e2f-6df8-08dd3f212f8e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 22:23:16.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7833

I noticed an interesting problem in Kernel CI.

For gcc-compiled kernel (x86_64-gcc, aarch64-gcc, s390x-gcc), the
iters/task_file test case can pass.

But for llvm-compiled kernel (x86_64-llvm-17, x86_64-llvm-18), the
iters/task_file test case fails.
The following is the error:

; if (task->parent->pid != parent_pid) @ iters_task_file.c:26
1: (79) r1 = *(u64 *)(r0 +1696)       ; R0_w=trusted_ptr_task_struct()
R1_w=rcu_ptr_or_null_task_struct(id=1)
2: (61) r1 = *(u32 *)(r1 +1672)
R1 invalid mem access 'rcu_ptr_or_null_'

I reproduced this error on my local laptop. With the same ebpf program,
it can be loaded normally into gcc-compiled kernel, but loading it into
llvm-compiled (make LLVM=1) kernel will result in an error.

The behavior of the gcc-compiled kernel is inconsistent with the
llvm-compiled kernel.

After my analysis, this is because of the following reasons:

Currently, llvm-compiled kernel can determine whether a pointer is rcu
or rcu_or_null based on btf_type_tag and allowlist, but gcc-compiled
kernel can only based on allowlist, because gcc does not support
btf_type_tag (commit 6fcd486b3a0a "bpf: Refactor RCU enforcement
in the verifier.").

Since the verifier cannot determine which fields are safe to read, it is
not feasible to set all untagged fields to PTR_UNTRUSTED, so just remove
the PTR_TRUSTED (commit afeebf9f57a4 "bpf: Undo strict enforcement for
walking untagged fields.").

These end up leading to an interesting problem.

static int check_ptr_to_btf_access(...)
{
...
    } else if (in_rcu_cs(env) && !type_may_be_null(reg->type)) {
       if (type_is_rcu(env, reg, field_name, btf_id)) {   (1)
          /* ignore __rcu tag and mark it MEM_RCU */
          flag |= MEM_RCU;
       } else if (flag & MEM_RCU ||                       (2)
          type_is_rcu_or_null(env, reg, field_name, btf_id)) {
          /* __rcu tagged pointers can be NULL */
          flag |= MEM_RCU | PTR_MAYBE_NULL;

          /* We always trust them */
          if (type_is_rcu_or_null(env, reg, field_name, btf_id) &&
             flag & PTR_UNTRUSTED)
                flag &= ~PTR_UNTRUSTED;
       } else if (flag & (MEM_PERCPU | MEM_USER)) {       (3)
          /* keep as-is */
       } else {                                           (4)
       /* walking unknown pointers yields old deprecated PTR_TO_BTF_ID */
          clear_trusted_flags(&flag);
       }
...
}

In gcc-compiled kernel, since task->parent is not in BTF_TYPE_SAFE_RCU
and BTF_TYPE_SAFE_RCU_OR_NULL, and since btf_type_tag is not supported,
there is no MEM_RCU, branch (4) is reached, just remove PTR_TRUSTED.
Although we cannot pass such a pointer to a kfunc with KF_TRUSTED_ARGS
or KF_RCU, we can still dereference it.

In llvm-compiled kernel, since task->parent is tagged with __rcu,
branch (2) is reached and flag is set to MEM_RCU | PTR_MAYBE_NULL.
This results in the "R1 invalid mem access rcu_ptr_or_null_" error
mentioned earlier.

If we remove the __rcu tag of task->parent, then there is no error,
even with the llvm-compiled kernel, because branch (4) is reached like
the gcc-compiled kernel.

This leads to the interesting result that pointers not tagged with __rcu
will have more freedom to dereference than pointers tagged with __rcu.

This result is obviously incorrect because the pointer may be NULL
whether or not it is tagged with __rcu.

But how to fix this problem seems a bit tricky.

It is not possible to mark every data structure member whether it may
be NULL.

If every pointer has PTR_MAYBE_NULL by default, chained dereferencing
will become cumbersome.

More discussion is welcome.

Many thanks.

