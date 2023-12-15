Return-Path: <linux-fsdevel+bounces-6204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB4A814F67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 19:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77CB280FA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 18:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3B03FB0F;
	Fri, 15 Dec 2023 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="aTLhddW6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35630112
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1702662880; x=1703267680;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	References:From:Organization:In-Reply-To:Content-Type; bh=Rz9AtI
	NA6OYtSQIn7pErjYsqjdFkf3rlyIsONxw+3Jg=; b=aTLhddW6grDlGZy68KAe0X
	eFfACDg+FdW5TSwGL8EeX7cNcTSffDoznJk5tCadLojk6S0HF1XgiR7JNkkzvrtz
	dVp/MV5KUTZOXtZgiLskR8t6+5HwuhGM1GfENBM3aKc6VFFrduxc9s8wDor58H0z
	s/Vhn6lHk5pYhz2itE9AQ=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Fri, 15 Dec 2023 12:54:40 -0500
Received: from [IPV6:2603:7000:73c:c800:b4b0:7f91:4ad9:4ee] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v23.5.1) 
	with ESMTPSA id md5001003762605.msg; Fri, 15 Dec 2023 12:54:39 -0500
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Fri, 15 Dec 2023 12:54:39 -0500
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:c800:b4b0:7f91:4ad9:4ee
X-MDHelo: [IPV6:2603:7000:73c:c800:b4b0:7f91:4ad9:4ee]
X-MDArrival-Date: Fri, 15 Dec 2023 12:54:39 -0500
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=17137614d0=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Message-ID: <ec4c70d6-b360-4492-9407-483bdab95c30@auristor.com>
Date: Fri, 15 Dec 2023 12:54:33 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] afs: Fix refcount underflow from error handling race
Content-Language: en-US
To: David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc: Bill MacAllister <bill@ca-zephyr.org>,
 Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2793879.1702331032@warthog.procyon.org.uk>
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
In-Reply-To: <2793879.1702331032@warthog.procyon.org.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000901010401070002010702"
X-MDCFSigsAdded: auristor.com

This is a cryptographically signed message in MIME format.

--------------ms000901010401070002010702
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2023 4:43 PM, David Howells wrote:
> Hi Linus,
>
> Could you apply this fix, please?
>
> David
> ---
> afs: Fix refcount underflow from error handling race
>
> If an AFS cell that has an unreachable (eg. ENETUNREACH) server listed (VL
> server or fileserver), an asynchronous probe to one of its addresses may
> fail immediately because sendmsg() returns an error.  When this happens, a
> refcount underflow can happen if certain events hit a very small window.
>
> The way this occurs is:
>
>   (1) There are two levels of "call" object, the afs_call and the
>       rxrpc_call.  Each of them can be transitioned to a "completed" state
>       in the event of success or failure.
>
>   (2) Asynchronous afs_calls are self-referential whilst they are active to
>       prevent them from evaporating when they're not being processed.  This
>       reference is disposed of when the afs_call is completed.
>
>       Note that an afs_call may only be completed once; once completed
>       completing it again will do nothing.
>
>   (3) When a call transmission is made, the app-side rxrpc code queues a Tx
>       buffer for the rxrpc I/O thread to transmit.  The I/O thread invokes
>       sendmsg() to transmit it - and in the case of failure, it transitions
>       the rxrpc_call to the completed state.
>
>   (4) When an rxrpc_call is completed, the app layer is notified.  In this
>       case, the app is kafs and it schedules a work item to process events
>       pertaining to an afs_call.
>
>   (5) When the afs_call event processor is run, it goes down through the
>       RPC-specific handler to afs_extract_data() to retrieve data from rxrpc
>       - and, in this case, it picks up the error from the rxrpc_call and
>       returns it.
>
>       The error is then propagated to the afs_call and that is completed
>       too.  At this point the self-reference is released.
>
>   (6) If the rxrpc I/O thread manages to complete the rxrpc_call within the
>       window between rxrpc_send_data() queuing the request packet and
>       checking for call completion on the way out, then
>       rxrpc_kernel_send_data() will return the error from sendmsg() to the
>       app.
>
>   (7) Then afs_make_call() will see an error and will jump to the error
>       handling path which will attempt to clean up the afs_call.
>
>   (8) The problem comes when the error handling path in afs_make_call()
>       tries to unconditionally drop an async afs_call's self-reference.
>       This self-reference, however, may already have been dropped by
>       afs_extract_data() completing the afs_call
>
>   (9) The refcount underflows when we return to afs_do_probe_vlserver() and
>       that tries to drop its reference on the afs_call.
>
> Fix this by making afs_make_call() attempt to complete the afs_call rather
> than unconditionally putting it.  That way, if afs_extract_data() manages
> to complete the call first, afs_make_call() won't do anything.
>
> The bug can be forced by making do_udp_sendmsg() return -ENETUNREACH and
> sticking an msleep() in rxrpc_send_data() after the 'success:' label to
> widen the race window.
>
> The error message looks something like:
>
>      refcount_t: underflow; use-after-free.
>      WARNING: CPU: 3 PID: 720 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
>      ...
>      RIP: 0010:refcount_warn_saturate+0xba/0x110
>      ...
>      afs_put_call+0x1dc/0x1f0 [kafs]
>      afs_fs_get_capabilities+0x8b/0xe0 [kafs]
>      afs_fs_probe_fileserver+0x188/0x1e0 [kafs]
>      afs_lookup_server+0x3bf/0x3f0 [kafs]
>      afs_alloc_server_list+0x130/0x2e0 [kafs]
>      afs_create_volume+0x162/0x400 [kafs]
>      afs_get_tree+0x266/0x410 [kafs]
>      vfs_get_tree+0x25/0xc0
>      fc_mount+0xe/0x40
>      afs_d_automount+0x1b3/0x390 [kafs]
>      __traverse_mounts+0x8f/0x210
>      step_into+0x340/0x760
>      path_openat+0x13a/0x1260
>      do_filp_open+0xaf/0x160
>      do_sys_openat2+0xaf/0x170
>
> or something like:
>
>      refcount_t: underflow; use-after-free.
>      ...
>      RIP: 0010:refcount_warn_saturate+0x99/0xda
>      ...
>      afs_put_call+0x4a/0x175
>      afs_send_vl_probes+0x108/0x172
>      afs_select_vlserver+0xd6/0x311
>      afs_do_cell_detect_alias+0x5e/0x1e9
>      afs_cell_detect_alias+0x44/0x92
>      afs_validate_fc+0x9d/0x134
>      afs_get_tree+0x20/0x2e6
>      vfs_get_tree+0x1d/0xc9
>      fc_mount+0xe/0x33
>      afs_d_automount+0x48/0x9d
>      __traverse_mounts+0xe0/0x166
>      step_into+0x140/0x274
>      open_last_lookups+0x1c1/0x1df
>      path_openat+0x138/0x1c3
>      do_filp_open+0x55/0xb4
>      do_sys_openat2+0x6c/0xb6
>
> Fixes: 34fa47612bfe ("afs: Fix race in async call refcounting")
> Reported-by: Bill MacAllister <bill@ca-zephyr.org>
> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1052304
> Suggested-by: Jeffrey E Altman <jaltman@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> Link: https://lore.kernel.org/r/2633992.1702073229@warthog.procyon.org.uk/ # v1
> ---
>   fs/afs/rxrpc.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index ed1644e7683f..d642d06a453b 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -424,7 +424,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
>   	if (call->async) {
>   		if (cancel_work_sync(&call->async_work))
>   			afs_put_call(call);
> -		afs_put_call(call);
> +		afs_set_call_complete(call, ret, 0);
>   	}
>   
>   	ac->error = ret;

According to an update from Bill MacAllister to 
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1052304 this patch 
fixes the bug.

Tested-by: Bill MacAllister <bill@ca-zephyr.org>


--------------ms000901010401070002010702
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DHEwggXSMIIEuqADAgECAhBAAYJpmi/rPn/F0fJyDlzMMA0GCSqGSIb3DQEBCwUAMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEz
MB4XDTIyMDgwNDE2MDQ0OFoXDTI1MTAzMTE2MDM0OFowcDEvMC0GCgmSJomT8ixkAQETH0Ew
MTQxMEQwMDAwMDE4MjY5OUEyRkQyMDAwMjMzQ0QxGTAXBgNVBAMTEEplZmZyZXkgRSBBbHRt
YW4xFTATBgNVBAoTDEF1cmlTdG9yIEluYzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCkC7PKBBZnQqDKPtZPMLAy77zo2DPvwtGnd1hNjPvbXrpGxUb3
xHZRtv179LHKAOcsY2jIctzieMxf82OMyhpBziMPsFAG/ukihBMFj3/xEeZVso3K27pSAyyN
fO/wJ0rX7G+ges22Dd7goZul8rPaTJBIxbZDuaykJMGpNq4PQ8VPcnYZx+6b+nJwJJoJ46kI
EEfNh3UKvB/vM0qtxS690iAdgmQIhTl+qfXq4IxWB6b+3NeQxgR6KLU4P7v88/tvJTpxIKkg
9xj89ruzeThyRFd2DSe3vfdnq9+g4qJSHRXyTft6W3Lkp7UWTM4kMqOcc4VSRdufVKBQNXjG
IcnhAgMBAAGjggKcMIICmDAOBgNVHQ8BAf8EBAMCBPAwgYQGCCsGAQUFBwEBBHgwdjAwBggr
BgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3QuY29tMEIGCCsGAQUF
BzAChjZodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NlcnRzL3RydXN0aWRjYWEx
My5wN2MwHwYDVR0jBBgwFoAULbfeG1l+KpguzeHUG+PFEBJe6RQwCQYDVR0TBAIwADCCASsG
A1UdIASCASIwggEeMIIBGgYLYIZIAYb5LwAGAgEwggEJMEoGCCsGAQUFBwIBFj5odHRwczov
L3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRt
bDCBugYIKwYBBQUHAgIwga0MgapUaGlzIFRydXN0SUQgQ2VydGlmaWNhdGUgaGFzIGJlZW4g
aXNzdWVkIGluIGFjY29yZGFuY2Ugd2l0aCBJZGVuVHJ1c3QncyBUcnVzdElEIENlcnRpZmlj
YXRlIFBvbGljeSBmb3VuZCBhdCBodHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRp
ZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8v
dmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NybC90cnVzdGlkY2FhMTMuY3JsMB8GA1UdEQQY
MBaBFGphbHRtYW5AYXVyaXN0b3IuY29tMB0GA1UdDgQWBBQB+nzqgljLocLTsiUn2yWqEc2s
gjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAJwV
eycprp8Ox1npiTyfwc5QaVaqtoe8Dcg2JXZc0h4DmYGW2rRLHp8YL43snEV93rPJVk6B2v4c
WLeQfaMrnyNeEuvHx/2CT44cdLtaEk5zyqo3GYJYlLcRVz6EcSGHv1qPXgDT0xB/25etwGYq
utYF4Chkxu4KzIpq90eDMw5ajkexw+8ARQz4N5+d6NRbmMCovd7wTGi8th/BZvz8hgKUiUJo
Qle4wDxrdXdnIhCP7g87InXKefWgZBF4VX21t2+hkc04qrhIJlHrocPG9mRSnnk2WpsY0MXt
a8ivbVKtfpY7uSNDZSKTDi1izEFH5oeQdYRkgIGb319a7FjslV8wggaXMIIEf6ADAgECAhBA
AXA7OrqBjMk8rp4OuNQSMA0GCSqGSIb3DQEBCwUAMEoxCzAJBgNVBAYTAlVTMRIwEAYDVQQK
EwlJZGVuVHJ1c3QxJzAlBgNVBAMTHklkZW5UcnVzdCBDb21tZXJjaWFsIFJvb3QgQ0EgMTAe
Fw0yMDAyMTIyMTA3NDlaFw0zMDAyMTIyMTA3NDlaMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQK
EwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAu6sUO01SDD99PM+QdZkNxKxJNt0NgQE+Zt6ixaNP0JKSjTd+SG5L
wqxBWjnOgI/3dlwgtSNeN77AgSs+rA4bK4GJ75cUZZANUXRKw/et8pf9Qn6iqgB63OdHxBN/
15KbM3HR+PyiHXQoUVIevCKW8nnlWnnZabT1FejOhRRKVUg5HACGOTfnCOONrlxlg+m1Vjgn
o1uNqNuLM/jkD1z6phNZ/G9IfZGI0ppHX5AA/bViWceX248VmefNhSR14ADZJtlAAWOi2un0
3bqrBPHA9nDyXxI8rgWLfUP5rDy8jx2hEItg95+ORF5wfkGUq787HBjspE86CcaduLka/Bk2
VwIDAQABo4IChzCCAoMwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkG
CCsGAQUFBwEBBH0wezAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVu
dHJ1c3QuY29tMEcGCCsGAQUFBzAChjtodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29t
L3Jvb3RzL2NvbW1lcmNpYWxyb290Y2ExLnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C
5yZUyI42djCCASQGA1UdIASCARswggEXMIIBEwYEVR0gADCCAQkwSgYIKwYBBQUHAgEWPmh0
dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRl
eC5odG1sMIG6BggrBgEFBQcCAjCBrQyBqlRoaXMgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBoYXMg
YmVlbiBpc3N1ZWQgaW4gYWNjb3JkYW5jZSB3aXRoIElkZW5UcnVzdCdzIFRydXN0SUQgQ2Vy
dGlmaWNhdGUgUG9saWN5IGZvdW5kIGF0IGh0dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20v
Y2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRleC5odG1sMEoGA1UdHwRDMEEwP6A9oDuGOWh0
dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20vY3JsL2NvbW1lcmNpYWxyb290Y2ExLmNy
bDAdBgNVHQ4EFgQULbfeG1l+KpguzeHUG+PFEBJe6RQwHQYDVR0lBBYwFAYIKwYBBQUHAwIG
CCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4ICAQB/7BKcygLX6Nl4a03cDHt7TLdPxCzFvDF2
bkVYCFTRX47UfeomF1gBPFDee3H/IPlLRmuTPoNt0qjdpfQzmDWN95jUXLdLPRToNxyaoB5s
0hOhcV6H08u3FHACBif55i0DTDzVSaBv0AZ9h1XeuGx4Fih1Vm3Xxz24GBqqVudvPRLyMJ7u
6hvBqTIKJ53uCs3dyQLZT9DXnp+kJv8y7ZSAY+QVrI/dysT8avtn8d7k7azNBkfnbRq+0e88
QoBnel6u+fpwbd5NLRHywXeH+phbzULCa+bLPRMqJaW2lbhvSWrMHRDy3/d8HvgnLCBFK2s4
Spns4YCN4xVcbqlGWzgolHCKUH39vpcsDo1ymZFrJ8QR6ihIn8FmJ5oKwAnnd/G6ADXFC9bu
db9+532phSAXOZrrecIQn+vtP366PC+aClAPsIIDJDsotS5z4X2JUFsNIuEgXGqhiKE7SuZb
rFG9sdcLprSlJN7TsRDc0W2b9nqwD+rj/5MN0C+eKwha+8ydv0+qzTyxPP90KRgaegGowC4d
UsZyTk2n4Z3MuAHX5nAZL/Vh/SyDj/ajorV44yqZBzQ3ChKhXbfUSwe2xMmygA2Z5DRwMRJn
p/BscizYdNk2WXJMTnH+wVLN8sLEwEtQR4eTLoFmQvrK2AMBS9kW5sBkMzINt/ZbbcZ3F+eA
MDGCAxQwggMQAgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUG
A1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwDQYJYIZIAWUDBAIBBQCg
ggGXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIxNTE3
NTQzM1owLwYJKoZIhvcNAQkEMSIEIFr4KxEV4rw4jozZG5BITPJSUU3mU92BOk5A4wKSINW+
MF0GCSsGAQQBgjcQBDFQME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEX
MBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwXwYLKoZIhvcNAQkQ
AgsxUKBOMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRy
dXN0SUQgQ0EgQTEzAhBAAYJpmi/rPn/F0fJyDlzMMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZI
hvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAjEaM
DleER8Ejscoay3PwykIGYrTp4cZYqCWEFeCurpxbThgXgITT8WzOVFOjyVhKPCScVbfUEmwn
tCnSXaHpBS16+MPg8w3sUzWMfnQUwOg8NJP337p8MQRuro8W/lPpq7D2DiNC9+tZOoZCZKF8
lGrfXem2lS3/dlx9SBbpKTgvNpuhjDvGNFSxGyWyD/kapqNVpWozDyyLQTBmhYVLSijNRz2y
pKQxCQnmFOHU53m9dpNxDfd9kXzH02ukfyX8/ToI1WE5SwyE6wzIuS9+ad36NndMQ2w7sct3
c1wKU2ukuWAcxKGpIQ5IyNG2QPLplV7Ob85SVKWnsza7kxkopQAAAAAAAA==
--------------ms000901010401070002010702--


