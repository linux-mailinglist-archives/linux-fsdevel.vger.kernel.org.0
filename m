Return-Path: <linux-fsdevel+bounces-79435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KUuEiqIqGn2vQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 20:29:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE4A20713B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 20:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D4893022077
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 19:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0839F3DBD58;
	Wed,  4 Mar 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="bFw8JDzW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BTHKAi/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBCF1F4176
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652581; cv=none; b=AvWL0vzf/Q1laO2iIyrbE+E+NQ8iBtSIr3eV2qWF4oQzFHhiwsRjdSThdNTj7Jo8t10yN+uQR+fWrMCn/nEIjTQqpsS9n035oZVZNM7PrqtDwJU9h8zWSOn+zKwM3lFCQ4STV6a6DJcGyagfkFxix9GfNkTLIhv3NQjwm/9Oo6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652581; c=relaxed/simple;
	bh=0UbN5//c0ndO0peM4b9JHEeKeAjOu7q+eRgZk3UU8JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFhHrrsI8eImm91hGFRkv9z100pkQq7vTIph95deKo17oip2M7+CHV1AkpaYs1kLn6MQXMzUMkmUUl7jtOr531Y+nRB7qyDOWwRdl5hlYbf9d5e8bGMBA9DOzF7vPf79bd7BmrX714WIJj/ZHdJ8eKXyFwS94DevBSuTQLhM6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=bFw8JDzW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BTHKAi/x; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9887BEC059C;
	Wed,  4 Mar 2026 14:29:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Mar 2026 14:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772652578;
	 x=1772738978; bh=+GBQQzWh02tlHuN7Vfy3PN3YxQIpBG+ABNf2SRGSjtA=; b=
	bFw8JDzWUdmAzalXpo04INO37DPN8As7vaitEiMVwkgRno2IvuThAjnDmQHt6P55
	/qyXVndR1cwBH0kNyWv5k7EzKiCsSDwLmXzesWbrUBY/dbZe1Efa+joiuScboAlX
	p9ZJPiQP47/b6VFOZHHu2gQV9IPBicwqLfa70kww1L5ECTpugQXrTBmLVDeliHjt
	MKiBHav4U0WuZt1GuJajf5EfG5dpdXEEAMr23KeRLC8BaKCEq2xV+I5SpkoDNADG
	kmaXDPR6/PXqz7Wf3VdDf7BktABJpnpILUpJXDXgBpTXBEuUVwxPPf8sEGKHzoab
	BL4jlASiJKydsF4dnnIe2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772652578; x=
	1772738978; bh=+GBQQzWh02tlHuN7Vfy3PN3YxQIpBG+ABNf2SRGSjtA=; b=B
	THKAi/xTE6rFquUkMN/ytz4owrcyo1APd6Xua4fco7Aqlt85U/w7Xm+GN+ZTBmdu
	erVaDRR1lXQRyqEGlkUFedt8CBUtKORll7hB5+VXQc+sA6S3ivfllTf1/vrB8zsp
	hICSaYgpQULGdjTxaZMKYgV3MhoUhM5uRQMJVHh3JiRVpptYxPHV2VnsZO2CQ/J+
	kP0RKB3wIdsfYDRhEzjAhoIkvZKLadv45/5+sXVdKFtz4QIomz9+Yi+MzgUqVioE
	ROSYn00jZrnnPFDkm2ZWJhOINvFXudMH+S/tSUobHfUXq7URgbcOQKCPNjBaJ7bi
	DwlpyV6djxH5coTkMy93g==
X-ME-Sender: <xms:IoioaeLYBUtq7uhpdiuVtAZNtQPI6QgQu3Jy7fG9v3dv3W6IeTM0JQ>
    <xme:IoioaZ2lIRZThJCeJU_8sXG34Ll06wPjXRuWsUj4_ub9uBFC19iPtcWhPracocMeX
    r_mnW123BbAhNB5u7MUgMXBGxxZQk0qr7NjMqvld0toHol4hDaj>
X-ME-Received: <xmr:IoioaYjsncKcRXblFeHRbC_sbJtXgk17vOrCwj9ydK63cFUXCA7rf4RL83IcVzEnXBUzhmW-pI9gY_0kDEylQbSsxnw73cYzoFzYNhM8oYc-ndbM_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeeugfevvdeggeeutdelgffgiefgffejheffkedtieduffehledvfeevgeej
    hedtjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsshgthhhusggvrhhtsegu
    ughnrdgtohhmpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoh
    epnhgvrghlsehgohhmphgrrdguvghv
X-ME-Proxy: <xmx:IoioaaVVDaHUwCJ_0ztmZrv6ymbJyn9GEcCS-r0YiOdmpxIJW4ck0w>
    <xmx:IoioaXWEMf4K0kk2P3eEsk1zPtoWNPMirwfDcJQLk8dembnP6q8SEA>
    <xmx:IoioaaiiItlae2pHjpn-xNi__DBuxLXwxK-fxGgcdgjPCoH-AHDiZw>
    <xmx:IoioaSaoykJB1khvVC0RRDsVYkVp1EdVDHbxWndR10Gv9YoHhtGkMA>
    <xmx:IoioaZh1cd2kV7Qtanl0PY4RtjbMkKdX56LGkb7HdZ4XRsG-stCw5dJ1>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 14:29:37 -0500 (EST)
Message-ID: <ee584989-d81d-4dea-b953-6acf44d76d13@bsbernd.com>
Date: Wed, 4 Mar 2026 20:29:35 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bschubert@ddn.com, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 miklos@szeredi.hu, neal@gompa.dev
References: <177258294351.1167732.4543535509077707738.stg-ugh@frogsfrogsfrogs>
 <0d3d5dfc-6237-4d6d-abeb-e7adddecf2d9@bsbernd.com>
 <20260304170652.GP13829@frogsfrogsfrogs>
 <20260304180602.GQ13829@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260304180602.GQ13829@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9FE4A20713B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ddn.com,gmail.com,vger.kernel.org,szeredi.hu,gompa.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79435-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,bsbernd.com:dkim,bsbernd.com:mid]
X-Rspamd-Action: no action



On 3/4/26 19:06, Darrick J. Wong wrote:
> On Wed, Mar 04, 2026 at 09:06:52AM -0800, Darrick J. Wong wrote:
>> On Wed, Mar 04, 2026 at 02:36:03PM +0100, Bernd Schubert wrote:
>>>
>>>
>>> On 3/4/26 01:11, Darrick J. Wong wrote:
>>>> Hi Bernd,
>>>>
>>>> Please pull this branch with changes for libfuse.
>>>>
>>>> As usual, I did a test-merge with the main upstream branch as of a few
>>>> minutes ago, and didn't see any conflicts.  Please let me know if you
>>>> encounter any problems.
>>>
>>> Hi Darrick,
>>>
>>> quite some problems actually ;)
>>>
>>> https://github.com/libfuse/libfuse/pull/1444
>>>
>>> Basically everything fails.  Build test with
>>
>> Doh :(
>>
>>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:24:10:
>>> fatal error: 'systemd/sd-daemon.h' file not found
>>>    24 | #include <systemd/sd-daemon.h>
>>>
>>>
>>> Two issues here:
>>> a) meson is not testing for sd-daemon.h?
>>
>> Hrm.  meson.build *should* have this clause to detect systemd:
>>
>> # Check for systemd support
>> systemd_system_unit_dir = get_option('systemdsystemunitdir')
>> if systemd_system_unit_dir == ''
>>   systemd = dependency('systemd', required: false)
>>   if systemd.found()
>>      systemd_system_unit_dir = systemd.get_variable(pkgconfig: 'systemd_system_unit_dir')
>>   endif
>> endif
>>
>> if systemd_system_unit_dir == ''
>>   warning('could not determine systemdsystemunitdir, systemd stuff will not be installed')
>> else
>>   private_cfg.set_quoted('SYSTEMD_SYSTEM_UNIT_DIR', systemd_system_unit_dir)
>>   private_cfg.set('HAVE_SYSTEMD', true)
>> endif
>>
>> # Check for libc SCM_RIGHTS support (aka Linux)
>> code = '''
>> #include <sys/socket.h>
>> int main(void) {
>>     int moo = SCM_RIGHTS;
>>     return moo;
>> }'''
>> if cc.links(code, name: 'libc SCM_RIGHTS support')
>>   private_cfg.set('HAVE_SCM_RIGHTS', true)
>> endif
>>
>> if private_cfg.get('HAVE_SCM_RIGHTS', false) and private_cfg.get('HAVE_SYSTEMD', false)
>>   private_cfg.set('HAVE_SERVICEMOUNT', true)
>> endif
>>
>>
>> But apparently it built fuse_service.c anyway?  I'll have to look deeper
>> into what github ci did, since the pkgconfig fil... oh crikey.
>>
>> systemd-dev contains the systemd.pc file, so the systemd.get_variable
>> call succeeds and returns a path, thereby enabling the build.  However,
>> the header files are in libsystemd-dev, and neither package depends on
>> the other.
>>
>> So I clearly need to test for the presence of sd-daemon.h in that first
>> clause that determines if HAVE_SYSTEMD gets set.

Or link test for systemd

>>
>>> a.1) If not available needs to disable that service? Because I don't
>>> think BSD has support for systemd.
>>
>> <nod>
>>
>>> b) .github/workflow/*.yml files need to be adjusted to add in the new
>>> dependency.
>>
>> Oh, ok.  The 'apt install' lines should probably add in systemd-dev.
>>
>>> Please also have a look at checkpatch (which is a plain linux copy) and
>>> the spelling test failures.
>>
>> Ok, will do.
> 
> ...and the immediate problem that I run into is that all the logs are
> hidden behind a login wall so I cannot read them. :(
> 
> (It leaked enough about the spelling errors that I can fix those, and
> I can run checkpatch locally, but I don't know what else went wrong with
> the bsd build or the abi check.)
> 


BSD errors are actually a bit tricky, because it runs them in a VM, one has
to look at "raw logs". I think ABI checks are failling as the normal build
test because of the meson issue.
BSD is this

2026-03-04T13:17:20.5979965Z [14/82] cc -Ilib/libfuse3.so.3.19.0.p -Ilib -I../lib -Iinclude -I../include -I. -I.. -fdiagnostics-color=always -Wall -Winvalid-pch -Wextra -std=gnu11 -O2 -g -D_REENTRANT -DHAVE_LIBFUSE_PRIVATE_CONFIG_H -Wno-sign-compare -D_FILE_OFFSET_BITS=64 -Wstrict-prototypes -Wmissing-declarations -Wwrite-strings -fno-strict-aliasing -fPIC -pthread -DFUSE_USE_VERSION=317 '-DFUSERMOUNT_DIR="/usr/local/bin"' -MD -MQ lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o -MF lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o.d -o lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o -c ../lib/fuse_service_stub.c
2026-03-04T13:17:20.6004021Z FAILED: [code=1] lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o 
2026-03-04T13:17:20.6008119Z cc -Ilib/libfuse3.so.3.19.0.p -Ilib -I../lib -Iinclude -I../include -I. -I.. -fdiagnostics-color=always -Wall -Winvalid-pch -Wextra -std=gnu11 -O2 -g -D_REENTRANT -DHAVE_LIBFUSE_PRIVATE_CONFIG_H -Wno-sign-compare -D_FILE_OFFSET_BITS=64 -Wstrict-prototypes -Wmissing-declarations -Wwrite-strings -fno-strict-aliasing -fPIC -pthread -DFUSE_USE_VERSION=317 '-DFUSERMOUNT_DIR="/usr/local/bin"' -MD -MQ lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o -MF lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o.d -o lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o -c ../lib/fuse_service_stub.c
2026-03-04T13:17:20.6012011Z In file included from ../lib/fuse_service_stub.c:21:
2026-03-04T13:17:20.6013206Z ../include/fuse_service_priv.h:12:2: error: unknown type name '__be32'
2026-03-04T13:17:20.6013899Z    12 |         __be32 pos;
2026-03-04T13:17:20.6014268Z       |         ^
2026-03-04T13:17:20.6014789Z ../include/fuse_service_priv.h:13:2: error: unknown type name '__be32'
2026-03-04T13:17:20.6015421Z    13 |         __be32 len;
2026-03-04T13:17:20.6015779Z       |         ^
2026-03-04T13:17:20.6016510Z ../include/fuse_service_priv.h:17:2: error: unknown type name '__be32'
2026-03-04T13:17:20.6017130Z    17 |         __be32 magic;
2026-03-04T13:17:20.6017506Z       |         ^
2026-03-04T13:17:20.6018004Z ../include/fuse_service_priv.h:18:2: error: unknown type name '__be32'
2026-03-04T13:17:20.6018615Z    18 |         __be32 argc;
2026-03-04T13:17:20.6018988Z       |         ^


Cheers,
Bernd

