Return-Path: <linux-fsdevel+bounces-5384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 179A580AF9E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 23:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BFAFB20BCE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 22:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC40758AD8;
	Fri,  8 Dec 2023 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="EX4VHl0B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [IPv6:2001:470:1f07:f77:70f5:c082:a96a:5685])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54C410E0
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 14:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1702074255; x=1702679055;
	i=jaltman@auristor.com; q=dns/txt; h=Content-Type:Mime-Version:
	Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:
	Message-Id:References:To; bh=nuoCccMDA+KEXMHWv21mLfyE00wKqqZPa6H
	V5fRAhvk=; b=EX4VHl0B8Q6UwfEI3MHaT0f1nykQuNLcuUKGg8HhjSHIQMB5Tig
	OtH8VgrclrNM8mSAGAqfecB0BX5CBCZgClthHNIB4GXS2wAMUmiEVcjHlkrm66Md
	upDm2TPL0u3K0ZneoGF39jBlXLlkXYaJu3f9If8kfQXmAodSIAABZgXo=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Fri, 08 Dec 2023 17:24:15 -0500
Received: from smtpclient.apple by auristor.com (208.125.0.235) (MDaemon PRO v23.5.1) 
	with ESMTPSA id md5001003759078.msg; Fri, 08 Dec 2023 17:24:14 -0500
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Fri, 08 Dec 2023 17:24:14 -0500
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:c800:3c87:1479:618:7ecb
X-MDHelo: smtpclient.apple
X-MDArrival-Date: Fri, 08 Dec 2023 17:24:14 -0500
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=17066f2475=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Content-Type: multipart/signed;
	boundary="Apple-Mail=_2E401917-E54B-40F3-B6DF-0397AFF858ED";
	protocol="application/pkcs7-signature";
	micalg=sha-256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] afs: Fix refcount underflow from error handling race
From: Jeffrey Altman <jaltman@auristor.com>
In-Reply-To: <2633992.1702073229@warthog.procyon.org.uk>
Date: Fri, 8 Dec 2023 17:23:56 -0500
Cc: Bill MacAllister <bill@ca-zephyr.org>,
 linux-afs@lists.infradead.org,
 Marc Dionne <marc.dionne@auristor.com>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <59A8FFE4-EAEF-42B5-B1B9-B8AF43EA11BA@auristor.com>
References: <2633992.1702073229@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-MDCFSigsAdded: auristor.com


--Apple-Mail=_2E401917-E54B-40F3-B6DF-0397AFF858ED
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Dec 8, 2023, at 5:07=E2=80=AFPM, David Howells =
<dhowells@redhat.com> wrote:
>=20
> If an AFS cell that has an unreachable (eg. ENETUNREACH) Volume =
Location
> server listed, an asynchronous probe to one of its addresses may fail
> immediately because sendmsg() returns an error.  When this happens, a
> refcount underflow can happen if certain events hit a very small =
window.
>=20
> The way this occurs is:
>=20
> (1) There are two levels of "call" object, the afs_call and the
>     rxrpc_call.  Each of them can be transitioned to a "completed" =
state
>     in the event of success or failure.
>=20
> (2) Asynchronous afs_calls are self-referential whilst they are active =
to
>     prevent them from evaporating when they're not being processed.  =
This
>     reference is disposed of when the afs_call is completed.
>=20
>     Note that an afs_call may only be completed once; once completed
>     completing it again will do nothing.
>=20
> (3) When a call transmission is made, the app-side rxrpc code queues a =
Tx
>     buffer for the rxrpc I/O thread to transmit.  The I/O thread =
invokes
>     sendmsg() to transmit it - and in the case of failure, it =
transitions
>     the rxrpc_call to the completed state.
>=20
> (4) When an rxrpc_call is completed, the app layer is notified.  In =
this
>     case, the app is kafs and it schedules a work item to process =
events
>     pertaining to an afs_call.
>=20
> (5) When the afs_call event processor is run, it goes down through the
>     RPC-specific handler to afs_extract_data() to retrieve data from =
rxrpc
>     - and, in this case, it picks up the error from the rxrpc_call and
>     returns it.
>=20
>     The error is then propagated to the afs_call and that is completed
>     too.  At this point the self-reference is released.
>=20
> (6) If the rxrpc I/O thread manages to complete the rxrpc_call within =
the
>     window between rxrpc_send_data() queuing the request packet and
>     checking for call completion on the way out, then
>     rxrpc_kernel_send_data() will return the error from sendmsg() to =
the
>     app.
>=20
> (7) Then afs_make_call() will see an error and will jump to the error
>     handling path which will attempt to clean up the afs_call.
>=20
> (8) The problem comes when the error handling path in afs_make_call()
>     tries to unconditionally drop an async afs_call's self-reference.
>     This self-reference, however, may already have been dropped by
>     afs_extract_data() completing the afs_call
>=20
> (9) The refcount underflows when we return to afs_do_probe_vlserver() =
and
>     that tries to drop its reference on the afs_call.
>=20
> Fix this by making afs_make_call() attempt to complete the afs_call =
rather
> than unconditionally putting it.  That way, if afs_extract_data() =
manages
> to complete the call first, afs_make_call() won't do anything.
>=20
> The bug can be forced by making do_udp_sendmsg() return -ENETUNREACH =
and
> sticking an msleep() in rxrpc_send_data() after the 'success:' label.
>=20
> The error message looks something like:
>=20
>    refcount_t: underflow; use-after-free.
>    WARNING: CPU: 3 PID: 720 at lib/refcount.c:28 =
refcount_warn_saturate+0xba/0x110
>    ...
>    RIP: 0010:refcount_warn_saturate+0xba/0x110
>    ...
>    afs_put_call+0x1dc/0x1f0 [kafs]
>    afs_fs_get_capabilities+0x8b/0xe0 [kafs]
>    afs_fs_probe_fileserver+0x188/0x1e0 [kafs]
>    afs_lookup_server+0x3bf/0x3f0 [kafs]
>    afs_alloc_server_list+0x130/0x2e0 [kafs]
>    afs_create_volume+0x162/0x400 [kafs]
>    afs_get_tree+0x266/0x410 [kafs]
>    vfs_get_tree+0x25/0xc0
>    fc_mount+0xe/0x40
>    afs_d_automount+0x1b3/0x390 [kafs]
>    __traverse_mounts+0x8f/0x210
>    step_into+0x340/0x760
>    path_openat+0x13a/0x1260
>    do_filp_open+0xaf/0x160
>    do_sys_openat2+0xaf/0x170
>=20
> or something like:
>=20
>    refcount_t: underflow; use-after-free.
>    ...
>    RIP: 0010:refcount_warn_saturate+0x99/0xda
>    ...
>    afs_put_call+0x4a/0x175
>    afs_send_vl_probes+0x108/0x172
>    afs_select_vlserver+0xd6/0x311
>    afs_do_cell_detect_alias+0x5e/0x1e9
>    afs_cell_detect_alias+0x44/0x92
>    afs_validate_fc+0x9d/0x134
>    afs_get_tree+0x20/0x2e6
>    vfs_get_tree+0x1d/0xc9
>    fc_mount+0xe/0x33
>    afs_d_automount+0x48/0x9d
>    __traverse_mounts+0xe0/0x166
>    step_into+0x140/0x274
>    open_last_lookups+0x1c1/0x1df
>    path_openat+0x138/0x1c3
>    do_filp_open+0x55/0xb4
>    do_sys_openat2+0x6c/0xb6
>=20
> Fixes: 34fa47612bfe ("afs: Fix race in async call refcounting")
> Reported-by: Bill MacAllister <bill@ca-zephyr.org>
> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1052304
> Suggested-by: Jeffrey E Altman <jaltman@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
> fs/afs/rxrpc.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index ed1644e7683f..d642d06a453b 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -424,7 +424,7 @@ void afs_make_call(struct afs_addr_cursor *ac, =
struct afs_call *call, gfp_t gfp)
> if (call->async) {
> if (cancel_work_sync(&call->async_work))
> afs_put_call(call);
> - afs_put_call(call);
> + afs_set_call_complete(call, ret, 0);
> }
>=20
> ac->error =3D ret;
>=20

Reviewed-by: Jeffrey Altman <jaltman@auristor.com>


--Apple-Mail=_2E401917-E54B-40F3-B6DF-0397AFF858ED
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDHEw
ggXSMIIEuqADAgECAhBAAYJpmi/rPn/F0fJyDlzMMA0GCSqGSIb3DQEBCwUAMDoxCzAJBgNVBAYT
AlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMB4XDTIyMDgw
NDE2MDQ0OFoXDTI1MTAzMTE2MDM0OFowcDEvMC0GCgmSJomT8ixkAQETH0EwMTQxMEQwMDAwMDE4
MjY5OUEyRkQyMDAwMjMzQ0QxGTAXBgNVBAMTEEplZmZyZXkgRSBBbHRtYW4xFTATBgNVBAoTDEF1
cmlTdG9yIEluYzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCk
C7PKBBZnQqDKPtZPMLAy77zo2DPvwtGnd1hNjPvbXrpGxUb3xHZRtv179LHKAOcsY2jIctzieMxf
82OMyhpBziMPsFAG/ukihBMFj3/xEeZVso3K27pSAyyNfO/wJ0rX7G+ges22Dd7goZul8rPaTJBI
xbZDuaykJMGpNq4PQ8VPcnYZx+6b+nJwJJoJ46kIEEfNh3UKvB/vM0qtxS690iAdgmQIhTl+qfXq
4IxWB6b+3NeQxgR6KLU4P7v88/tvJTpxIKkg9xj89ruzeThyRFd2DSe3vfdnq9+g4qJSHRXyTft6
W3Lkp7UWTM4kMqOcc4VSRdufVKBQNXjGIcnhAgMBAAGjggKcMIICmDAOBgNVHQ8BAf8EBAMCBPAw
gYQGCCsGAQUFBwEBBHgwdjAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVu
dHJ1c3QuY29tMEIGCCsGAQUFBzAChjZodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2Nl
cnRzL3RydXN0aWRjYWExMy5wN2MwHwYDVR0jBBgwFoAULbfeG1l+KpguzeHUG+PFEBJe6RQwCQYD
VR0TBAIwADCCASsGA1UdIASCASIwggEeMIIBGgYLYIZIAYb5LwAGAgEwggEJMEoGCCsGAQUFBwIB
Fj5odHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5k
ZXguaHRtbDCBugYIKwYBBQUHAgIwga0MgapUaGlzIFRydXN0SUQgQ2VydGlmaWNhdGUgaGFzIGJl
ZW4gaXNzdWVkIGluIGFjY29yZGFuY2Ugd2l0aCBJZGVuVHJ1c3QncyBUcnVzdElEIENlcnRpZmlj
YXRlIFBvbGljeSBmb3VuZCBhdCBodHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmlj
YXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8vdmFsaWRh
dGlvbi5pZGVudHJ1c3QuY29tL2NybC90cnVzdGlkY2FhMTMuY3JsMB8GA1UdEQQYMBaBFGphbHRt
YW5AYXVyaXN0b3IuY29tMB0GA1UdDgQWBBQB+nzqgljLocLTsiUn2yWqEc2sgjAdBgNVHSUEFjAU
BggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAJwVeycprp8Ox1npiTyfwc5Q
aVaqtoe8Dcg2JXZc0h4DmYGW2rRLHp8YL43snEV93rPJVk6B2v4cWLeQfaMrnyNeEuvHx/2CT44c
dLtaEk5zyqo3GYJYlLcRVz6EcSGHv1qPXgDT0xB/25etwGYqutYF4Chkxu4KzIpq90eDMw5ajkex
w+8ARQz4N5+d6NRbmMCovd7wTGi8th/BZvz8hgKUiUJoQle4wDxrdXdnIhCP7g87InXKefWgZBF4
VX21t2+hkc04qrhIJlHrocPG9mRSnnk2WpsY0MXta8ivbVKtfpY7uSNDZSKTDi1izEFH5oeQdYRk
gIGb319a7FjslV8wggaXMIIEf6ADAgECAhBAAXA7OrqBjMk8rp4OuNQSMA0GCSqGSIb3DQEBCwUA
MEoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxJzAlBgNVBAMTHklkZW5UcnVzdCBD
b21tZXJjaWFsIFJvb3QgQ0EgMTAeFw0yMDAyMTIyMTA3NDlaFw0zMDAyMTIyMTA3NDlaMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu6sUO01SDD99PM+QdZkNxKxJNt0NgQE+Zt6i
xaNP0JKSjTd+SG5LwqxBWjnOgI/3dlwgtSNeN77AgSs+rA4bK4GJ75cUZZANUXRKw/et8pf9Qn6i
qgB63OdHxBN/15KbM3HR+PyiHXQoUVIevCKW8nnlWnnZabT1FejOhRRKVUg5HACGOTfnCOONrlxl
g+m1Vjgno1uNqNuLM/jkD1z6phNZ/G9IfZGI0ppHX5AA/bViWceX248VmefNhSR14ADZJtlAAWOi
2un03bqrBPHA9nDyXxI8rgWLfUP5rDy8jx2hEItg95+ORF5wfkGUq787HBjspE86CcaduLka/Bk2
VwIDAQABo4IChzCCAoMwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkGCCsG
AQUFBwEBBH0wezAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3Qu
Y29tMEcGCCsGAQUFBzAChjtodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL3Jvb3RzL2Nv
bW1lcmNpYWxyb290Y2ExLnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C5yZUyI42djCCASQG
A1UdIASCARswggEXMIIBEwYEVR0gADCCAQkwSgYIKwYBBQUHAgEWPmh0dHBzOi8vc2VjdXJlLmlk
ZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRleC5odG1sMIG6BggrBgEFBQcC
AjCBrQyBqlRoaXMgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBoYXMgYmVlbiBpc3N1ZWQgaW4gYWNjb3Jk
YW5jZSB3aXRoIElkZW5UcnVzdCdzIFRydXN0SUQgQ2VydGlmaWNhdGUgUG9saWN5IGZvdW5kIGF0
IGh0dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRl
eC5odG1sMEoGA1UdHwRDMEEwP6A9oDuGOWh0dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20v
Y3JsL2NvbW1lcmNpYWxyb290Y2ExLmNybDAdBgNVHQ4EFgQULbfeG1l+KpguzeHUG+PFEBJe6RQw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4ICAQB/7BKcygLX
6Nl4a03cDHt7TLdPxCzFvDF2bkVYCFTRX47UfeomF1gBPFDee3H/IPlLRmuTPoNt0qjdpfQzmDWN
95jUXLdLPRToNxyaoB5s0hOhcV6H08u3FHACBif55i0DTDzVSaBv0AZ9h1XeuGx4Fih1Vm3Xxz24
GBqqVudvPRLyMJ7u6hvBqTIKJ53uCs3dyQLZT9DXnp+kJv8y7ZSAY+QVrI/dysT8avtn8d7k7azN
BkfnbRq+0e88QoBnel6u+fpwbd5NLRHywXeH+phbzULCa+bLPRMqJaW2lbhvSWrMHRDy3/d8Hvgn
LCBFK2s4Spns4YCN4xVcbqlGWzgolHCKUH39vpcsDo1ymZFrJ8QR6ihIn8FmJ5oKwAnnd/G6ADXF
C9budb9+532phSAXOZrrecIQn+vtP366PC+aClAPsIIDJDsotS5z4X2JUFsNIuEgXGqhiKE7SuZb
rFG9sdcLprSlJN7TsRDc0W2b9nqwD+rj/5MN0C+eKwha+8ydv0+qzTyxPP90KRgaegGowC4dUsZy
Tk2n4Z3MuAHX5nAZL/Vh/SyDj/ajorV44yqZBzQ3ChKhXbfUSwe2xMmygA2Z5DRwMRJnp/BscizY
dNk2WXJMTnH+wVLN8sLEwEtQR4eTLoFmQvrK2AMBS9kW5sBkMzINt/ZbbcZ3F+eAMDGCAqYwggKi
AgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJ
RCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwDQYJYIZIAWUDBAIBBQCgggEpMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIwODIyMjM1NlowLwYJKoZIhvcNAQkE
MSIEIJGG3Bq+kY3s0c6tWgBu6nzvmALY4F/kyxkWw2UglKQqMF0GCSsGAQQBgjcQBDFQME4wOjEL
MAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTMC
EEABgmmaL+s+f8XR8nIOXMwwXwYLKoZIhvcNAQkQAgsxUKBOMDoxCzAJBgNVBAYTAlVTMRIwEAYD
VQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzAhBAAYJpmi/rPn/F0fJyDlzM
MA0GCSqGSIb3DQEBCwUABIIBAFTzznXyaNRSFgTJbTX29KoUaokfUFEb/+bIjuGw6vjpafu2kxiI
f0PwGd/qQf1xOZfUEJKj+BSfbAC8CyWHogoxb1xC7wFgQuNav/eH9P3OnbUk7hejujd0gNayg5Kc
rcYjO4mTQEpVVVmt5Scm7kKz+Dvn/QIOWieb/CeDzz6QxRI8qLcwT5WLb7dV8VwzRz6Sp0qpsMxy
q/CQsL75OJcxIauqaW7uMfyUcPkVKANmPQcgLHaQv2jNZDVjEJTuI9CKKapSlF7iNsts7BYuDn9G
e/T6dsxU9F8s+7uYAixPykLze8K2KJKSpD45ZopbZ+e9NTyE4H7HsRaJGDr8WCIAAAAAAAA=
--Apple-Mail=_2E401917-E54B-40F3-B6DF-0397AFF858ED--


