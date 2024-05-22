Return-Path: <linux-fsdevel+bounces-19950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18EF8CB8D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 04:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19748B21135
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 02:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A3ADF6C;
	Wed, 22 May 2024 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcEJYwLB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2E17F3;
	Wed, 22 May 2024 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716343599; cv=none; b=LZAQpPMi+Uq2wuxFHUU28D3FIiNqAtEuak6EPxugT6qn658pivXnTwD/P7NhEleyemmstQ5gbHnDs29w+buLJ1QgjpXxxETHKY8AJoiLB2e9HL88ABMBCIXiYCaa5owqshAGPHew7kjEJVgNB+KV4EW7lqPZrMKIYHo5+vgejrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716343599; c=relaxed/simple;
	bh=HOyOje05xOvnm1LzK2hiPdZdYL36rNfc8mgu4aPHMYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5KkCW5gAQub2NIPoBA+JUkB6nkv/5+Ce7Ko+WuxOEeDBdMFnRIvBjeSdzdCS28OkD7ybDlzsHjHUdOFxawM8b4LLakpGSj7dXcQ8Ls/hb2XNu4+lonKsKgUx8Hn6ShoX0BOROaUroyUnumEiiTjrcPuLxUd3fvddTSwoAA9T30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcEJYwLB; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52449b7aa2bso3210372e87.3;
        Tue, 21 May 2024 19:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716343595; x=1716948395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kjc9sQnvaD8n/6XF+5odscZn0J1sIRPDWHQAxSfpUxU=;
        b=CcEJYwLBaYpIINh/K736oKU+rw+qqR8FtfcOOdu3iMh+WZwvuFML5Vhu2QyitNQehb
         BgOAEqWOIDSGCbWYbbv2m9eWYF1UMb6h8ecp17PQooJR4jDy9YrGoJZX7GHWMc/6u2uS
         XaCVzJSjLm2atajVY8oeaPEObv8ATPOvYz4xD9RIAtm2sfkoVG70eVoWxdpfG7IoATNl
         9Ak9fJe9jBrrHkFX1mKR6rgW2POLUuNsLTEQnqAp01qvbNnp9q5KjJsYJijkdYYqdl00
         I3l3cPodKaiaI+4IZ+h7wtr1Jhr0VX86ZBXzI4SzYGcM+Fgd86P5ZvwU+I/SjR4qCWpu
         7K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716343595; x=1716948395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjc9sQnvaD8n/6XF+5odscZn0J1sIRPDWHQAxSfpUxU=;
        b=Z4vLwEJAfbHjXjXb33AbG1RDKwascD81MFm1TpXvBGz0973kR54Mixu3Yl2S4KN+Hl
         5eD2QHVktqS1yEH1xDxtpx4jAB198ZQUjhVGhE2er1ieACqTW6Y5RahPL4u1GpnDazv6
         foO+M/71rTpBIB8V3dxWhGpvpBatsxlpg0BdfJ0ERPuQ0/dTqLkhy5M1BTPfiFo4UE2e
         Lt/lafoUq5LktyoiLYw9bRynS6ThvSwuFW5CoSQOnj+HouFENTZPnR3f2BBhzEzm6xdN
         EmD0tFED6WS839OcaMgqR6GO1Q9CQ76v38kVDkFRmlDZElXtYZFP+7q32qFSUYepc3Hr
         t4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4cQ88qkRLkKu0clH6dsZUKhyITC979Zp7/0mh4f0tktnk+DoOpOH5LJA1eT6dpAmjq+9zwFW8QyRszIjJMHBZ8kMxXaA0KfUOjut17yQqzgw9E9K8wXNcRvJmpvZvEAS6kp30kWPHwczwa51SqxDoivSOCyA4sAGeRQ0sh/ooNSvjIbx0uiM=
X-Gm-Message-State: AOJu0YyzcD+RFau6bS+aDMxGVFLpELeQJUh8vyyGzwiXKyoymlMWGHmd
	dudmuTBgmviyBkEDBy9I9iAvrSRpG3rIT7Ma7dQ82oPNTTtDk3YzYvsFGwOg/USqKpEkQ0OIHqw
	tPMSwd2coy0YOX+sVx0S6ZBhrRY8=
X-Google-Smtp-Source: AGHT+IEm4SeKXs1Gw5qUld1Les2ccD7b32M2NUDuHHGit1wcmyur9Q5tIF5priiKbnOSTcxOs+zt6C/N3cIn/5HnPRo=
X-Received: by 2002:ac2:5f56:0:b0:51f:452f:927b with SMTP id
 2adb3069b0e04-526c0878924mr255832e87.45.1716343595198; Tue, 21 May 2024
 19:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <351482.1716336150@warthog.procyon.org.uk>
In-Reply-To: <351482.1716336150@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Tue, 21 May 2024 21:06:23 -0500
Message-ID: <CAH2r5muWt2X55sVfk6Ngct-+c_SFepPzQdhUiZNQT+o_twiivw@mail.gmail.com>
Subject: Re: [PATCH v2] netfs: Fix io_uring based write-through
To: David Howells <dhowells@redhat.com>
Cc: Steve French <stfrench@microsoft.com>, Jeff Layton <jlayton@kernel.org>, 
	Enzo Matsumiya <ematsumiya@suse.de>, Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, 
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004e126c06190162ef"

--0000000000004e126c06190162ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

fixed minor checpatch warning (updated patch attached)

On Tue, May 21, 2024 at 7:02=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> This can be triggered by mounting a cifs filesystem with a cache=3Dstrict
> mount option and then, using the fsx program from xfstests, doing:
>
>         ltp/fsx -A -d -N 1000 -S 11463 -P /tmp /cifs-mount/foo \
>           --replay-ops=3Dgen112-fsxops
>
> Where gen112-fsxops holds:
>
>         fallocate 0x6be7 0x8fc5 0x377d3
>         copy_range 0x9c71 0x77e8 0x2edaf 0x377d3
>         write 0x2776d 0x8f65 0x377d3
>
> The problem is that netfs_io_request::len is being used for two purposes
> and ends up getting set to the amount of data we transferred, not the
> amount of data the caller asked to be transferred (for various reasons,
> such as mmap'd writes, we might end up rounding out the data written to t=
he
> server to include the entire folio at each end).
>
> Fix this by keeping the amount we were asked to write in ->len and using
> ->submitted to track what we issued ops for.  Then, when we come to calli=
ng
> ->ki_complete(), ->len is the right size.
>
> This also required netfs_cleanup_dio_write() to change since we're no
> longer advancing wreq->len.  Use wreq->transferred instead as we might ha=
ve
> done a short read and wreq->len must be set when setting up a direct writ=
e.
>
> With this, the generic/112 xfstest passes if cifs is forced to put all
> non-DIO opens into write-through mode.
>
> Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Steve French <stfrench@microsoft.com>
> cc: Enzo Matsumiya <ematsumiya@suse.de>
> cc: netfs@lists.linux.dev
> cc: v9fs@lists.linux.dev
> cc: linux-afs@lists.infradead.org
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/295086.1716298663@warthog.procyon.org.uk/=
 # v1
> ---
>  Changes
>  =3D=3D=3D=3D=3D=3D=3D
>  ver #2)
>   - Set wreq->len when doing direct writes.
>
>  fs/netfs/direct_write.c  |    5 +++--
>  fs/netfs/write_collect.c |    7 ++++---
>  fs/netfs/write_issue.c   |    2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
> index 608ba6416919..93b41e121042 100644
> --- a/fs/netfs/direct_write.c
> +++ b/fs/netfs/direct_write.c
> @@ -12,7 +12,7 @@
>  static void netfs_cleanup_dio_write(struct netfs_io_request *wreq)
>  {
>         struct inode *inode =3D wreq->inode;
> -       unsigned long long end =3D wreq->start + wreq->len;
> +       unsigned long long end =3D wreq->start + wreq->transferred;
>
>         if (!wreq->error &&
>             i_size_read(inode) < end) {
> @@ -92,8 +92,9 @@ static ssize_t netfs_unbuffered_write_iter_locked(struc=
t kiocb *iocb, struct iov
>         __set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
>         if (async)
>                 wreq->iocb =3D iocb;
> +       wreq->len =3D iov_iter_count(&wreq->io_iter);
>         wreq->cleanup =3D netfs_cleanup_dio_write;
> -       ret =3D netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), iov_ite=
r_count(&wreq->io_iter));
> +       ret =3D netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), wreq->l=
en);
>         if (ret < 0) {
>                 _debug("begin =3D %zd", ret);
>                 goto out;
> diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
> index 60112e4b2c5e..426cf87aaf2e 100644
> --- a/fs/netfs/write_collect.c
> +++ b/fs/netfs/write_collect.c
> @@ -510,7 +510,7 @@ static void netfs_collect_write_results(struct netfs_=
io_request *wreq)
>          * stream has a gap that can be jumped.
>          */
>         if (notes & SOME_EMPTY) {
> -               unsigned long long jump_to =3D wreq->start + wreq->len;
> +               unsigned long long jump_to =3D wreq->start + READ_ONCE(wr=
eq->submitted);
>
>                 for (s =3D 0; s < NR_IO_STREAMS; s++) {
>                         stream =3D &wreq->io_streams[s];
> @@ -690,10 +690,11 @@ void netfs_write_collection_worker(struct work_stru=
ct *work)
>         wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
>
>         if (wreq->iocb) {
> -               wreq->iocb->ki_pos +=3D wreq->transferred;
> +               size_t written =3D min(wreq->transferred, wreq->len);
> +               wreq->iocb->ki_pos +=3D written;
>                 if (wreq->iocb->ki_complete)
>                         wreq->iocb->ki_complete(
> -                               wreq->iocb, wreq->error ? wreq->error : w=
req->transferred);
> +                               wreq->iocb, wreq->error ? wreq->error : w=
ritten);
>                 wreq->iocb =3D VFS_PTR_POISON;
>         }
>
> diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
> index acbfd1f5ee9d..3aa86e268f40 100644
> --- a/fs/netfs/write_issue.c
> +++ b/fs/netfs/write_issue.c
> @@ -254,7 +254,7 @@ static void netfs_issue_write(struct netfs_io_request=
 *wreq,
>         stream->construct =3D NULL;
>
>         if (subreq->start + subreq->len > wreq->start + wreq->submitted)
> -               wreq->len =3D wreq->submitted =3D subreq->start + subreq-=
>len - wreq->start;
> +               WRITE_ONCE(wreq->submitted, subreq->start + subreq->len -=
 wreq->start);
>         netfs_do_issue_write(stream, subreq);
>  }
>
>


--=20
Thanks,

Steve

--0000000000004e126c06190162ef
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-netfs-Fix-io_uring-based-write-through.patch"
Content-Disposition: attachment; 
	filename="0001-netfs-Fix-io_uring-based-write-through.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lwh6niyi0>
X-Attachment-Id: f_lwh6niyi0

RnJvbSA3MzI2M2QyZTYwMjNlNGQ3ZWYyZGM2ZDkxN2UwMWQzOGZkMmExYTI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpE
YXRlOiBXZWQsIDIyIE1heSAyMDI0IDAxOjAyOjMwICswMTAwClN1YmplY3Q6IFtQQVRDSF0gbmV0
ZnM6IEZpeCBpb191cmluZyBiYXNlZCB3cml0ZS10aHJvdWdoCgpUaGlzIGNhbiBiZSB0cmlnZ2Vy
ZWQgYnkgbW91bnRpbmcgYSBjaWZzIGZpbGVzeXN0ZW0gd2l0aCBhIGNhY2hlPXN0cmljdAptb3Vu
dCBvcHRpb24gYW5kIHRoZW4sIHVzaW5nIHRoZSBmc3ggcHJvZ3JhbSBmcm9tIHhmc3Rlc3RzLCBk
b2luZzoKCiAgICAgICAgbHRwL2ZzeCAtQSAtZCAtTiAxMDAwIC1TIDExNDYzIC1QIC90bXAgL2Np
ZnMtbW91bnQvZm9vIFwKICAgICAgICAgIC0tcmVwbGF5LW9wcz1nZW4xMTItZnN4b3BzCgpXaGVy
ZSBnZW4xMTItZnN4b3BzIGhvbGRzOgoKICAgICAgICBmYWxsb2NhdGUgMHg2YmU3IDB4OGZjNSAw
eDM3N2QzCiAgICAgICAgY29weV9yYW5nZSAweDljNzEgMHg3N2U4IDB4MmVkYWYgMHgzNzdkMwog
ICAgICAgIHdyaXRlIDB4Mjc3NmQgMHg4ZjY1IDB4Mzc3ZDMKClRoZSBwcm9ibGVtIGlzIHRoYXQg
bmV0ZnNfaW9fcmVxdWVzdDo6bGVuIGlzIGJlaW5nIHVzZWQgZm9yIHR3byBwdXJwb3NlcwphbmQg
ZW5kcyB1cCBnZXR0aW5nIHNldCB0byB0aGUgYW1vdW50IG9mIGRhdGEgd2UgdHJhbnNmZXJyZWQs
IG5vdCB0aGUKYW1vdW50IG9mIGRhdGEgdGhlIGNhbGxlciBhc2tlZCB0byBiZSB0cmFuc2ZlcnJl
ZCAoZm9yIHZhcmlvdXMgcmVhc29ucywKc3VjaCBhcyBtbWFwJ2Qgd3JpdGVzLCB3ZSBtaWdodCBl
bmQgdXAgcm91bmRpbmcgb3V0IHRoZSBkYXRhIHdyaXR0ZW4gdG8gdGhlCnNlcnZlciB0byBpbmNs
dWRlIHRoZSBlbnRpcmUgZm9saW8gYXQgZWFjaCBlbmQpLgoKRml4IHRoaXMgYnkga2VlcGluZyB0
aGUgYW1vdW50IHdlIHdlcmUgYXNrZWQgdG8gd3JpdGUgaW4gLT5sZW4gYW5kIHVzaW5nCi0+c3Vi
bWl0dGVkIHRvIHRyYWNrIHdoYXQgd2UgaXNzdWVkIG9wcyBmb3IuICBUaGVuLCB3aGVuIHdlIGNv
bWUgdG8gY2FsbGluZwotPmtpX2NvbXBsZXRlKCksIC0+bGVuIGlzIHRoZSByaWdodCBzaXplLgoK
VGhpcyBhbHNvIHJlcXVpcmVkIG5ldGZzX2NsZWFudXBfZGlvX3dyaXRlKCkgdG8gY2hhbmdlIHNp
bmNlIHdlJ3JlIG5vCmxvbmdlciBhZHZhbmNpbmcgd3JlcS0+bGVuLiAgVXNlIHdyZXEtPnRyYW5z
ZmVycmVkIGluc3RlYWQgYXMgd2UgbWlnaHQgaGF2ZQpkb25lIGEgc2hvcnQgcmVhZCBhbmQgd3Jl
cS0+bGVuIG11c3QgYmUgc2V0IHdoZW4gc2V0dGluZyB1cCBhIGRpcmVjdCB3cml0ZS4KCldpdGgg
dGhpcywgdGhlIGdlbmVyaWMvMTEyIHhmc3Rlc3QgcGFzc2VzIGlmIGNpZnMgaXMgZm9yY2VkIHRv
IHB1dCBhbGwKbm9uLURJTyBvcGVucyBpbnRvIHdyaXRlLXRocm91Z2ggbW9kZS4KCkZpeGVzOiAy
ODhhY2UyZjU3YzkgKCJuZXRmczogTmV3IHdyaXRlYmFjayBpbXBsZW1lbnRhdGlvbiIpClNpZ25l
ZC1vZmYtYnk6IERhdmlkIEhvd2VsbHMgPGRob3dlbGxzQHJlZGhhdC5jb20+CmNjOiBKZWZmIExh
eXRvbiA8amxheXRvbkBrZXJuZWwub3JnPgpjYzogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNy
b3NvZnQuY29tPgpjYzogRW56byBNYXRzdW1peWEgPGVtYXRzdW1peWFAc3VzZS5kZT4KY2M6IG5l
dGZzQGxpc3RzLmxpbnV4LmRldgpjYzogdjlmc0BsaXN0cy5saW51eC5kZXYKY2M6IGxpbnV4LWFm
c0BsaXN0cy5pbmZyYWRlYWQub3JnCmNjOiBsaW51eC1jaWZzQHZnZXIua2VybmVsLm9yZwpjYzog
bGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmcKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvci8yOTUwODYuMTcxNjI5ODY2M0B3YXJ0aG9nLnByb2N5b24ub3JnLnVrLyAjIHYxClNpZ25l
ZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9u
ZXRmcy9kaXJlY3Rfd3JpdGUuYyAgfCA1ICsrKy0tCiBmcy9uZXRmcy93cml0ZV9jb2xsZWN0LmMg
fCA4ICsrKysrLS0tCiBmcy9uZXRmcy93cml0ZV9pc3N1ZS5jICAgfCAyICstCiAzIGZpbGVzIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9u
ZXRmcy9kaXJlY3Rfd3JpdGUuYyBiL2ZzL25ldGZzL2RpcmVjdF93cml0ZS5jCmluZGV4IGY1MTY0
NjBlOTk0ZS4uODhmMmFkZmFiNzVlIDEwMDY0NAotLS0gYS9mcy9uZXRmcy9kaXJlY3Rfd3JpdGUu
YworKysgYi9mcy9uZXRmcy9kaXJlY3Rfd3JpdGUuYwpAQCAtMTIsNyArMTIsNyBAQAogc3RhdGlj
IHZvaWQgbmV0ZnNfY2xlYW51cF9kaW9fd3JpdGUoc3RydWN0IG5ldGZzX2lvX3JlcXVlc3QgKndy
ZXEpCiB7CiAJc3RydWN0IGlub2RlICppbm9kZSA9IHdyZXEtPmlub2RlOwotCXVuc2lnbmVkIGxv
bmcgbG9uZyBlbmQgPSB3cmVxLT5zdGFydCArIHdyZXEtPmxlbjsKKwl1bnNpZ25lZCBsb25nIGxv
bmcgZW5kID0gd3JlcS0+c3RhcnQgKyB3cmVxLT50cmFuc2ZlcnJlZDsKIAogCWlmICghd3JlcS0+
ZXJyb3IgJiYKIAkgICAgaV9zaXplX3JlYWQoaW5vZGUpIDwgZW5kKSB7CkBAIC05Miw4ICs5Miw5
IEBAIHNzaXplX3QgbmV0ZnNfdW5idWZmZXJlZF93cml0ZV9pdGVyX2xvY2tlZChzdHJ1Y3Qga2lv
Y2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqCiAJX19zZXRfYml0KE5FVEZTX1JSRVFfVVBMT0FE
X1RPX1NFUlZFUiwgJndyZXEtPmZsYWdzKTsKIAlpZiAoYXN5bmMpCiAJCXdyZXEtPmlvY2IgPSBp
b2NiOworCXdyZXEtPmxlbiA9IGlvdl9pdGVyX2NvdW50KCZ3cmVxLT5pb19pdGVyKTsKIAl3cmVx
LT5jbGVhbnVwID0gbmV0ZnNfY2xlYW51cF9kaW9fd3JpdGU7Ci0JcmV0ID0gbmV0ZnNfdW5idWZm
ZXJlZF93cml0ZSh3cmVxLCBpc19zeW5jX2tpb2NiKGlvY2IpLCBpb3ZfaXRlcl9jb3VudCgmd3Jl
cS0+aW9faXRlcikpOworCXJldCA9IG5ldGZzX3VuYnVmZmVyZWRfd3JpdGUod3JlcSwgaXNfc3lu
Y19raW9jYihpb2NiKSwgd3JlcS0+bGVuKTsKIAlpZiAocmV0IDwgMCkgewogCQlfZGVidWcoImJl
Z2luID0gJXpkIiwgcmV0KTsKIAkJZ290byBvdXQ7CmRpZmYgLS1naXQgYS9mcy9uZXRmcy93cml0
ZV9jb2xsZWN0LmMgYi9mcy9uZXRmcy93cml0ZV9jb2xsZWN0LmMKaW5kZXggNjAxMTJlNGIyYzVl
Li43YTVkMjI5Y2IxYzcgMTAwNjQ0Ci0tLSBhL2ZzL25ldGZzL3dyaXRlX2NvbGxlY3QuYworKysg
Yi9mcy9uZXRmcy93cml0ZV9jb2xsZWN0LmMKQEAgLTUxMCw3ICs1MTAsNyBAQCBzdGF0aWMgdm9p
ZCBuZXRmc19jb2xsZWN0X3dyaXRlX3Jlc3VsdHMoc3RydWN0IG5ldGZzX2lvX3JlcXVlc3QgKndy
ZXEpCiAJICogc3RyZWFtIGhhcyBhIGdhcCB0aGF0IGNhbiBiZSBqdW1wZWQuCiAJICovCiAJaWYg
KG5vdGVzICYgU09NRV9FTVBUWSkgewotCQl1bnNpZ25lZCBsb25nIGxvbmcganVtcF90byA9IHdy
ZXEtPnN0YXJ0ICsgd3JlcS0+bGVuOworCQl1bnNpZ25lZCBsb25nIGxvbmcganVtcF90byA9IHdy
ZXEtPnN0YXJ0ICsgUkVBRF9PTkNFKHdyZXEtPnN1Ym1pdHRlZCk7CiAKIAkJZm9yIChzID0gMDsg
cyA8IE5SX0lPX1NUUkVBTVM7IHMrKykgewogCQkJc3RyZWFtID0gJndyZXEtPmlvX3N0cmVhbXNb
c107CkBAIC02OTAsMTAgKzY5MCwxMiBAQCB2b2lkIG5ldGZzX3dyaXRlX2NvbGxlY3Rpb25fd29y
a2VyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIAl3YWtlX3VwX2JpdCgmd3JlcS0+ZmxhZ3Ms
IE5FVEZTX1JSRVFfSU5fUFJPR1JFU1MpOwogCiAJaWYgKHdyZXEtPmlvY2IpIHsKLQkJd3JlcS0+
aW9jYi0+a2lfcG9zICs9IHdyZXEtPnRyYW5zZmVycmVkOworCQlzaXplX3Qgd3JpdHRlbiA9IG1p
bih3cmVxLT50cmFuc2ZlcnJlZCwgd3JlcS0+bGVuKTsKKworCQl3cmVxLT5pb2NiLT5raV9wb3Mg
Kz0gd3JpdHRlbjsKIAkJaWYgKHdyZXEtPmlvY2ItPmtpX2NvbXBsZXRlKQogCQkJd3JlcS0+aW9j
Yi0+a2lfY29tcGxldGUoCi0JCQkJd3JlcS0+aW9jYiwgd3JlcS0+ZXJyb3IgPyB3cmVxLT5lcnJv
ciA6IHdyZXEtPnRyYW5zZmVycmVkKTsKKwkJCQl3cmVxLT5pb2NiLCB3cmVxLT5lcnJvciA/IHdy
ZXEtPmVycm9yIDogd3JpdHRlbik7CiAJCXdyZXEtPmlvY2IgPSBWRlNfUFRSX1BPSVNPTjsKIAl9
CiAKZGlmZiAtLWdpdCBhL2ZzL25ldGZzL3dyaXRlX2lzc3VlLmMgYi9mcy9uZXRmcy93cml0ZV9p
c3N1ZS5jCmluZGV4IGUxOTAwNDNiYzBkYS4uODZkYWQ3ZTQyMDJiIDEwMDY0NAotLS0gYS9mcy9u
ZXRmcy93cml0ZV9pc3N1ZS5jCisrKyBiL2ZzL25ldGZzL3dyaXRlX2lzc3VlLmMKQEAgLTI1NCw3
ICsyNTQsNyBAQCBzdGF0aWMgdm9pZCBuZXRmc19pc3N1ZV93cml0ZShzdHJ1Y3QgbmV0ZnNfaW9f
cmVxdWVzdCAqd3JlcSwKIAlzdHJlYW0tPmNvbnN0cnVjdCA9IE5VTEw7CiAKIAlpZiAoc3VicmVx
LT5zdGFydCArIHN1YnJlcS0+bGVuID4gd3JlcS0+c3RhcnQgKyB3cmVxLT5zdWJtaXR0ZWQpCi0J
CXdyZXEtPmxlbiA9IHdyZXEtPnN1Ym1pdHRlZCA9IHN1YnJlcS0+c3RhcnQgKyBzdWJyZXEtPmxl
biAtIHdyZXEtPnN0YXJ0OworCQlXUklURV9PTkNFKHdyZXEtPnN1Ym1pdHRlZCwgc3VicmVxLT5z
dGFydCArIHN1YnJlcS0+bGVuIC0gd3JlcS0+c3RhcnQpOwogCW5ldGZzX2RvX2lzc3VlX3dyaXRl
KHN0cmVhbSwgc3VicmVxKTsKIH0KIAotLSAKMi40MC4xCgo=
--0000000000004e126c06190162ef--

