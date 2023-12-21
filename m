Return-Path: <linux-fsdevel+bounces-6739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E32F81B8E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32741C24212
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D14539F9;
	Thu, 21 Dec 2023 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="tTnz52JX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1664A539E5
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1703166298; x=1703771098;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	References:From:Organization:In-Reply-To:Content-Type; bh=c/re8N
	2RTRY16Af01KHruI/CBOaBMSVEEub7mgcnL4c=; b=tTnz52JXXJ+9+CRUHRC3u0
	zb/sf2TvhG0Gs19wdOPnG3qLBxB46K2KG/NV2aiwg1NWZKvSb68vrpfH/2KXY0DB
	K/xEZSVQp6SUl4rwktWFva8bi4KBn1TIHSy5L2UaYzAtfmtMqDxu158/sCnNJ6Im
	1hJHa/8XYKUGQm6asje1E=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 21 Dec 2023 08:44:58 -0500
Received: from [IPV6:2603:7000:73c:c800:969b:c070:cc58:a112] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v23.5.1) 
	with ESMTPSA id md5001003765282.msg; Thu, 21 Dec 2023 08:44:57 -0500
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 21 Dec 2023 08:44:57 -0500
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:c800:969b:c070:cc58:a112
X-MDHelo: [IPV6:2603:7000:73c:c800:969b:c070:cc58:a112]
X-MDArrival-Date: Thu, 21 Dec 2023 08:44:57 -0500
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=17191febf5=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Message-ID: <42348ec3-687e-4f3c-8cfc-6b5632afe433@auristor.com>
Date: Thu, 21 Dec 2023 08:44:48 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] afs: Fix use-after-free due to get/remove race in volume
 tree
Content-Language: en-US
To: David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <307296.1702463129@warthog.procyon.org.uk>
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
In-Reply-To: <307296.1702463129@warthog.procyon.org.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030808000400000502020001"
X-MDCFSigsAdded: auristor.com

This is a cryptographically signed message in MIME format.

--------------ms030808000400000502020001
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/2023 5:25 AM, David Howells wrote:
> When an afs_volume struct is put, its refcount is reduced to 0 before the
> cell->volume_lock is taken and the volume removed from the cell->volumes
> tree.  Unfortunately, this means that the lookup code can race and see a
> volume with a zero ref in the tree, resulting in a use-after-free:
>
>          refcount_t: addition on 0; use-after-free.
>          WARNING: CPU: 3 PID: 130782 at lib/refcount.c:25 refcount_warn_saturate+0x7a/0xda
>          ...
>          RIP: 0010:refcount_warn_saturate+0x7a/0xda
>          ...
>          Call Trace:
>           <TASK>
>           ? __warn+0x8b/0xf5
>           ? report_bug+0xbf/0x11b
>           ? refcount_warn_saturate+0x7a/0xda
>           ? handle_bug+0x3c/0x5b
>           ? exc_invalid_op+0x13/0x59
>           ? asm_exc_invalid_op+0x16/0x20
>           ? refcount_warn_saturate+0x7a/0xda
>           ? refcount_warn_saturate+0x7a/0xda
>           afs_get_volume+0x3d/0x55
>           afs_create_volume+0x126/0x1de
>           afs_validate_fc+0xfe/0x130
>           afs_get_tree+0x20/0x2e5
>           vfs_get_tree+0x1d/0xc9
>           do_new_mount+0x13b/0x22e
>           do_mount+0x5d/0x8a
>           __do_sys_mount+0x100/0x12a
>           do_syscall_64+0x3a/0x94
>           entry_SYSCALL_64_after_hwframe+0x62/0x6a
>
> Fix this by:
>
>   (1) When putting, use a flag to indicate if the volume has been removed
>       from the tree and skip the rb_erase if it has.
>
>   (2) When looking up, use a conditional ref increment and if it fails
>       because the refcount is 0, replace the node in the tree and set the
>       removal flag.
>
> Fixes: 20325960f875 ("afs: Reorganise volume and server trees to be rooted on the cell")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>   fs/afs/internal.h |    2 ++
>   fs/afs/volume.c   |   26 +++++++++++++++++++++++---
>   2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index a812952be1c9..7385d62c8cf5 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -586,6 +586,7 @@ struct afs_volume {
>   #define AFS_VOLUME_OFFLINE	4	/* - T if volume offline notice given */
>   #define AFS_VOLUME_BUSY		5	/* - T if volume busy notice given */
>   #define AFS_VOLUME_MAYBE_NO_IBULK 6	/* - T if some servers don't have InlineBulkStatus */
> +#define AFS_VOLUME_RM_TREE	7	/* - Set if volume removed from cell->volumes */
>   #ifdef CONFIG_AFS_FSCACHE
>   	struct fscache_volume	*cache;		/* Caching cookie */
>   #endif
> @@ -1513,6 +1514,7 @@ extern struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *,
>   extern struct afs_volume *afs_create_volume(struct afs_fs_context *);
>   extern int afs_activate_volume(struct afs_volume *);
>   extern void afs_deactivate_volume(struct afs_volume *);
> +bool afs_try_get_volume(struct afs_volume *volume, enum afs_volume_trace reason);
>   extern struct afs_volume *afs_get_volume(struct afs_volume *, enum afs_volume_trace);
>   extern void afs_put_volume(struct afs_net *, struct afs_volume *, enum afs_volume_trace);
>   extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
> diff --git a/fs/afs/volume.c b/fs/afs/volume.c
> index 29d483c80281..115c081a8e2c 100644
> --- a/fs/afs/volume.c
> +++ b/fs/afs/volume.c
> @@ -32,8 +32,13 @@ static struct afs_volume *afs_insert_volume_into_cell(struct afs_cell *cell,
>   		} else if (p->vid > volume->vid) {
>   			pp = &(*pp)->rb_right;
>   		} else {
> -			volume = afs_get_volume(p, afs_volume_trace_get_cell_insert);
> -			goto found;
> +			if (afs_try_get_volume(p, afs_volume_trace_get_cell_insert)) {
> +				volume = p;
> +				goto found;
> +			}
> +
> +			set_bit(AFS_VOLUME_RM_TREE, &volume->flags);
> +			rb_replace_node_rcu(&p->cell_node, &volume->cell_node, &cell->volumes);
>   		}
>   	}
>   
> @@ -56,7 +61,8 @@ static void afs_remove_volume_from_cell(struct afs_volume *volume)
>   				 afs_volume_trace_remove);
>   		write_seqlock(&cell->volume_lock);
>   		hlist_del_rcu(&volume->proc_link);
> -		rb_erase(&volume->cell_node, &cell->volumes);
> +		if (!test_and_set_bit(AFS_VOLUME_RM_TREE, &volume->flags))
> +			rb_erase(&volume->cell_node, &cell->volumes);
>   		write_sequnlock(&cell->volume_lock);
>   	}
>   }
> @@ -231,6 +237,20 @@ static void afs_destroy_volume(struct afs_net *net, struct afs_volume *volume)
>   	_leave(" [destroyed]");
>   }
>   
> +/*
> + * Try to get a reference on a volume record.
> + */
> +bool afs_try_get_volume(struct afs_volume *volume, enum afs_volume_trace reason)
> +{
> +	int r;
> +
> +	if (__refcount_inc_not_zero(&volume->ref, &r)) {
> +		trace_afs_volume(volume->vid, r + 1, reason);
> +		return true;
> +	}
> +	return false;
> +}
> +
>   /*
>    * Get a reference on a volume record.
>    */
>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>


--------------ms030808000400000502020001
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
ggGXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIyMTEz
NDQ0OFowLwYJKoZIhvcNAQkEMSIEIE4EJ0QL3dEhkjODoMYa8x9KBX2hYmSvG0jXjnfsSP99
MF0GCSsGAQQBgjcQBDFQME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEX
MBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwXwYLKoZIhvcNAQkQ
AgsxUKBOMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRy
dXN0SUQgQ0EgQTEzAhBAAYJpmi/rPn/F0fJyDlzMMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZI
hvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAdYKl
xXfUt2B7brQYs0bMfC/z+MXwy2MReR5oy6l6d0Lxq3uodvI2ePqjPTyP44z9D1uuxU2DTXMN
Rur73+63cU0DSEMh72oxtuQLkoRjRAZn1mFlLJNexLSv0kaHhU3ExZG7HyuZysI6Xf2Z+wTg
WOqJq0xnm+qiVyyZslwTh0ogOUm+3NtpFeKuLixhAy0oSKvGc9p8ECcF9DGHK3G4FPtRLQ/z
n1og8M4skhhaDpIGdH+YwhPt+/k+0J1XUXaeW4FD1E8RfKW1YDTRupUeN6V2Tmg2dcAnbSim
SIAncCwLcHjRm0h/gnJ9gd0aOI5PGz98LodI5hNKZrv3Fddq0AAAAAAAAA==
--------------ms030808000400000502020001--


