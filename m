Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617932ADC57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 17:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgKJQn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 11:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgKJQn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:43:58 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45031C0613CF;
        Tue, 10 Nov 2020 08:43:57 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id v143so7515985qkb.2;
        Tue, 10 Nov 2020 08:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KMWbx+wIxMX04mmHKghtNOC/ct04FiRyKuQcjWAwzKs=;
        b=iuy6TNkJfVl4KRJAAXU3cRxOhTgpOpMfrvfPrjqAq3tYmcwwGUYoWRWfdrQz53DQhY
         1pX2A0ZppZy4jBbgGJMT5MsYZQBUo/4exWtSrFd1m/+QG2roenv6S5cCHVd84FY89FHk
         cgw5uSXrV5KRFP6x46UIW/Y0Gs1B9zziaPSRh26Dqqii3jstNfH+m+ej/4G6XdhPCyqg
         pEywf4FT5zpzwIDo7NSzq/HRFpwQ/YYBpQlSTZPNpQAvJLPNus0RD/dYgpPfp8Mr4u2r
         z51FsWqIzLcEe0O2iSXpHiBjXVPsPBoIJhR2IykVDe1xqlte3po0L88kAQFGTbKCWXW0
         5rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KMWbx+wIxMX04mmHKghtNOC/ct04FiRyKuQcjWAwzKs=;
        b=L9ca8HUb8/UrYUpBlA49E4JpZ09DgG4LODWZnY4/o+NuG5AQELRssmDOQRtxjeHL3p
         EfEI5obhncJJ4/5UBDzWcc4VZgMypd6543EbNdBZQ4Kpac1c6yDxUZzZjD0q7HeuKsP0
         Fs5rhK6dt70du/NG3njwgs3G95//R2OiSPMXYCPpF+Q/9eoimJhdUfs70YXsOf9f+lk8
         xv29fX70qtOsKs0mt6HCsN9Lod7WH9l5r1AMko43MC/NF17paSpsdmzJOPJuQekApcev
         vbIs1+EptLbYtFE87yKa0LnSCRgDcG5p93hX7RnjFQzLj5vrmctMzJAHrf1qMnPkU0N7
         GAVw==
X-Gm-Message-State: AOAM532rd1nla18NdMpcBMxrx6szr1IGJcQqPLE+jSqL8M2QAdk0zJSI
        HLQLPyVXqJaJQqDQKAqjHa4DTS3AQDlpbUaJDEE=
X-Google-Smtp-Source: ABdhPJzTc9sxKnRjrg7FKVq/43ru2290b3tBpeWO2ZPxM+yD/pJT0fep5GYvuJ6Lo1jRarTGzYX3I5JzxrAp+oi9OWU=
X-Received: by 2002:a37:e207:: with SMTP id g7mr8515729qki.44.1605026635907;
 Tue, 10 Nov 2020 08:43:55 -0800 (PST)
MIME-Version: 1.0
References: <20201102174737.2740-1-sargun@sargun.me>
In-Reply-To: <20201102174737.2740-1-sargun@sargun.me>
From:   Alban Crequy <alban.crequy@gmail.com>
Date:   Tue, 10 Nov 2020 17:43:44 +0100
Message-ID: <CAMXgnP5cVoLKTGPOAO+aLEAGLpkjACy1e4iLBKkfp8Gv1U77xA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] NFS: Fix interaction between fs_context and user namespaces
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mauricio@kinvolk.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I tested the patches on top of 5.10.0-rc3+ and I could mount an NFS
share with a different user namespace. fsopen() is done in the
container namespaces (user, mnt and net namespaces) while fsconfig(),
fsmount() and move_mount() are done on the host namespaces. The mount
on the host is available in the container via mount propagation from
the host mount.

With this, the files on the NFS server with uid 0 are available in the
container with uid 0. On the host, they are available with uid
4294967294 (make_kuid(&init_user_ns, -2)).

The code to reproduce my test is available at:
https://github.com/kinvolk/nfs-mount-in-userns
And the results and traces are attached at the end.

While the basic feature works, I have some thoughts.

First, doing the fsopen() in the container namespaces implements two
features in one step:
1. Selection of the userns for the id mapping translation.
2. Selection of the netns for the connection to the NFS server.

I was wondering if this only considers the scenario where the user
wants to make the connection to the NFS server from the network
namespace of the container. I think there is another valid use case to
use the userns of the container but the netns of the host or a
third-party netns. We can use the correct set of setns() to do the
fsopen() in the container userns but in the host netns, but then we=E2=80=
=99d
be in a netns that does not belong to the current userns, so we would
not have any capability over it. In my tests, that seems to work fine
when the netns and the userns of the fs_context are not related.

Still, I would find the API cleaner if the userns and netns were
selected explicitly with something like:

sfd =3D fsopen("nfs4", FSOPEN_CLOEXEC);
usernsfd =3D pidfd_open(...); or usernsfd =3D open(=E2=80=9C/proc/pid/ns/us=
er=E2=80=9D)
fsconfig(sfd, FSCONFIG_SET_FD, "userns", NULL, usernsfd);
netnsfd =3D pidfd_open(...); or netnsfd =3D open(=E2=80=9C/proc/pid/ns/net=
=E2=80=9D)
fsconfig(sfd, FSCONFIG_SET_FD, "netns", NULL, netnsfd);

This would avoid the need for fd passing after the fsopen(). This
would require fsconfig() (possibly in nfs_fs_context_parse_param()) to
do the capability check but making it more explicit sounds better to
me.

Second, the capability check in fsopen() is the following:
  if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))

This means that we cannot just create a temporary userns with the
desired id mapping, but we additionally need to enter a mntns owned by
the userns. However the code in fsopen() does not seem to do anything
with the mntns (The new mount will only be associated with the current
mntns at move_mount() time), so we could just create a temporary
userns + mntns. It seems weird to me that the capability check is done
in relation to the current mntns even though the code does not do
anything with it.

In Kubernetes, the NFS mount is done before creating the user
namespace. pkg/kubelet/kubelet.go Kubelet's syncPod() will do the
following in this order:
1. Mount the volumes with CSI or other volume implementations:
WaitForAttachAndMount() line 1667
2. Call the CRI's createPodSandbox via kl.containerRuntime.SyncPod()
line 1678 to create the user namespace and network namespace.

This means that at the time of the NFS mount, we have not yet created
the user namespace or the network namespace, and even less configured
it with the CNI plugin. With this API where the id mapping for the NFS
mount is decided at the superblock level, we would need to refactor
the Kubelet code to be able to call the CSI mount after the creation
of the sandbox, and after the configuration with CNI. This will be
more complicated to integrate in Kubernetes than the idmapped mounts
patch set where the id mapping is set at the bind mount level
(https://lists.linuxfoundation.org/pipermail/containers/2020-October/042477=
.html).
However, it is less invasive.

This approach works for NFS volumes in Kubernetes but would not work
with other volumes like hostPath (bind mount from the host) where we
don=E2=80=99t have a new superblock.

Lastly, I checked the implementation of nfs_compare_super() and it
seems fine. In Kubernetes, we want to be able to create several
Kubernetes pods with different userns and mount the same NFS share in
several pods. The kernel will have to create different NFS superblocks
for that scenario and it does that correctly in nfs_compare_super() by
comparing the userns and comparing the netns as well.

-----

Running ./nfs-mount-in-userns
strace: Process 4022 attached
[pid  4022] fsopen("nfs4", FSOPEN_CLOEXEC) =3D 6
[pid  4022] +++ exited with 0 +++
--- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D4022,
si_uid=3D0, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
fsconfig(7, FSCONFIG_SET_STRING, "source", "127.0.0.1:/server", 0) =3D 0
fsconfig(7, FSCONFIG_SET_STRING, "vers", "4.2", 0) =3D 0
fsconfig(7, FSCONFIG_SET_STRING, "addr", "127.0.0.1", 0) =3D 0
fsconfig(7, FSCONFIG_SET_STRING, "clientaddr", "127.0.0.1", 0) =3D 0
fsconfig(7, FSCONFIG_CMD_CREATE, NULL, NULL, 0) =3D 0
fsmount(7, FSMOUNT_CLOEXEC, 0)          =3D 6
move_mount(6, "", AT_FDCWD, "/mnt/nfs", MOVE_MOUNT_F_EMPTY_PATH) =3D 0
+++ exited with 0 +++
./nfs-mount-in-userns returned 0
last dmesg line about nfs4_create_server
[55258.702256] nfs4_create_server: Using creds from non-init userns
459 55 0:40 / /mnt/nfs rw,relatime shared:187 - nfs4 127.0.0.1:/server
rw,vers=3D4.2,rsize=3D524288,wsize=3D524288,namlen=3D255,hard,proto=3Dtcp,t=
imeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D127.0.0.1,local_lock=3Dnone,a=
ddr=3D127.0.0.1

+ : 'Files on the NFS server:'
+ ls -lani /server/
total 20
1048578 drwxr-xr-x.  5    0    0 4096 Nov 10 09:19 .
      2 dr-xr-xr-x. 21    0    0 4096 Nov  9 14:25 ..
1048582 drwx------.  2    0    0 4096 Nov 10 09:19 dir-0
1048583 drwx------.  2 1000 1000 4096 Nov 10 09:19 dir-1000
1048584 drwx------.  2 3000 3000 4096 Nov 10 09:19 dir-3000
1048579 -rw-------.  1    0    0    0 Nov 10 09:19 file-0
1048580 -rw-------.  1 1000 1000    0 Nov 10 09:19 file-1000
1048581 -rw-------.  1 3000 3000    0 Nov 10 09:19 file-3000

+ : 'Files on the NFS mountpoint (from container PoV):'
+ nsenter -U -m -n -t 4002 sh -c 'ls -lani /mnt/nfs'
total 20
1048578 drwxr-xr-x. 5     0     0 4096 Nov 10 09:19 .
 786433 drwxr-xr-x. 3 65534 65534 4096 May 16 16:08 ..
1048582 drwx------. 2     0     0 4096 Nov 10 09:19 dir-0
1048583 drwx------. 2 65534 65534 4096 Nov 10 09:19 dir-1000
1048584 drwx------. 2 65534 65534 4096 Nov 10 09:19 dir-3000
1048579 -rw-------. 1     0     0    0 Nov 10 09:19 file-0
1048580 -rw-------. 1 65534 65534    0 Nov 10 09:19 file-1000
1048581 -rw-------. 1 65534 65534    0 Nov 10 09:19 file-3000

+ : 'Files on the NFS mountpoint (from host PoV):'
+ ls -lani /mnt/nfs/
total 20
1048578 drwxr-xr-x. 5       1000       1000 4096 Nov 10 09:19 .
 786433 drwxr-xr-x. 3          0          0 4096 May 16 16:08 ..
1048582 drwx------. 2       1000       1000 4096 Nov 10 09:19 dir-0
1048583 drwx------. 2 4294967294 4294967294 4096 Nov 10 09:19 dir-1000
1048584 drwx------. 2 4294967294 4294967294 4096 Nov 10 09:19 dir-3000
1048579 -rw-------. 1       1000       1000    0 Nov 10 09:19 file-0
1048580 -rw-------. 1 4294967294 4294967294    0 Nov 10 09:19 file-1000
1048581 -rw-------. 1 4294967294 4294967294    0 Nov 10 09:19 file-3000

Alban

On Mon, 2 Nov 2020 at 18:48, Sargun Dhillon <sargun@sargun.me> wrote:
>
> This is effectively a resend, but re-based atop Anna's current tree. I ca=
n
> add the samples back in an another patchset.
>
> Right now, it is possible to mount NFS with an non-matching super block
> user ns, and NFS sunrpc user ns. This (for the user) results in an awkwar=
d
> set of interactions if using anything other than auth_null, where the UID=
s
> being sent to the server are different than the local UIDs being checked.
> This can cause "breakage", where if you try to communicate with the NFS
> server with any other set of mappings, it breaks.
>
> This is after the initial v5.10 merge window, so hopefully this patchset
> can be reconsidered, and maybe we can make forward progress? I think that
> it takes a relatively conservative approach in enabling user namespaces,
> and it prevents the case where someone is using auth_gss (for now), as th=
e
> mappings are non-trivial.
>
> Changes since v3:
>   * Rebase atop Anna's tree
> Changes since v2:
>   * Removed samples
>   * Split out NFSv2/v3 patchset from NFSv4 patchset
>   * Added restrictions around use
> Changes since v1:
>   * Added samples
>
> Sargun Dhillon (2):
>   NFS: NFSv2/NFSv3: Use cred from fs_context during mount
>   NFSv4: Refactor NFS to use user namespaces
>
>  fs/nfs/client.c     | 10 ++++++++--
>  fs/nfs/nfs4client.c | 27 ++++++++++++++++++++++++++-
>  fs/nfs/nfs4idmap.c  |  2 +-
>  fs/nfs/nfs4idmap.h  |  3 ++-
>  4 files changed, 37 insertions(+), 5 deletions(-)
>
>
> base-commit: 8c39076c276be0b31982e44654e2c2357473258a
> --
> 2.25.1
>
