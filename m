Return-Path: <linux-fsdevel+bounces-72400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F6BCF4FD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 18:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CC5A3024247
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4A033CE84;
	Mon,  5 Jan 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8Q9NmxI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA41633C19C;
	Mon,  5 Jan 2026 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633948; cv=none; b=NM+Oc8fvXPpx9NkODRZpEFN2O+yYDNxY+FAv78GCYLRWE2AwycSVr5RSKLnbZNuhCQK60/XLhMAwT3Ww9LebUslPXuolvdrhNKCbOnWtUuXZX+h5LuktjUwWm/NuBL1NOFHNydSnavVtOOx8bqAuPHMWuuwlScOHGNrPRUl0HaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633948; c=relaxed/simple;
	bh=x95DtXJCYS6wcEJY6JqeoykHFS0mOctMYEzHq7cXito=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3O1OvVeozcH9Z5cmiphG4OtgX4lLZxt+7bmY4h+ktE6M8OHqoWxZYv/BVP6RH/SrB8wPyPozub4UfpgkTQQ5R7+Nn8gYxNkPGq1F6uo8pt0D073YdiW7anMzSLqDboddclB5/OepABVPJlx4/fkonUP80qQgmoKqt4dlQicmJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8Q9NmxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E41C116D0;
	Mon,  5 Jan 2026 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767633947;
	bh=x95DtXJCYS6wcEJY6JqeoykHFS0mOctMYEzHq7cXito=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8Q9NmxIAYEMdo4y5672UdCrFh+2G/UtK2KMRN8HzevET1U4/0PgLSL5YZdYOXKfI
	 eRktulPpEdt7GqyX0AfSZhhp6rix7SwBj0WwBcTekvM4iNO4OM9qha6nfAFS1aGojd
	 h7YlXVb6GeG52vBXc7k1l+FRbh+4KR3cd8BZFaPppdoXQ/ZQ2i6rS2AyMXNP0fCqcc
	 Zu7hhUU2pK+S1Euo6n9uEySQXuw9Ly6YEqHD6tUsW43n+VSAcSc+pPEKk9bJiqesO8
	 k/pxCzEgj/aKvofL50Tnz5oQMWS3/nRCv2E+udlRyXpaS3CcBCni9cDxYbTbfK5GY4
	 t2K1MJ0T+6xpw==
Date: Mon, 5 Jan 2026 09:25:47 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fs: send uevents for filesystem mount events
Message-ID: <20260105172547.GA191481@frogsfrogsfrogs>
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
 <176602332527.688213.9644123318095990966.stgit@frogsfrogsfrogs>
 <20251224-imitieren-flugtauglich-dcef25c57c8d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224-imitieren-flugtauglich-dcef25c57c8d@brauner>

On Wed, Dec 24, 2025 at 01:47:25PM +0100, Christian Brauner wrote:
> On Wed, Dec 17, 2025 at 06:04:29PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Add the ability to send uevents whenever a filesystem mounts, unmounts,
> > or goes down.  This will enable XFS to start daemons whenever a
> > filesystem is first mounted.
> > 
> > Regrettably, we can't wire this directly into get_tree_bdev_flags or
> > generic_shutdown_super because not all filesystems set up a kobject
> > representation in sysfs, and the VFS has no idea if a filesystem
> > actually does that.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> 
> I have issues with uevents as a mechanism for this. Uevents are tied to
> network namespaces and they are not really namespaced appropriately. Any
> filesystem that hooks into this mechanism will spew uevents into the
> initial network namespace unconditionally. Any container mountable
> filesystem that wants to use this interface will spam the host with
> this event though the even is completely useless without appropriate
> meta information about the relevant mount namespaces and further
> parameters. This is a design dead end going forward imho. So please
> let's not do this.

Ok.  Initially I'd assumed that any xfs mounts would have to be made
initially by whatever's managing the containers and then bindmounted
into an actual container, but fanotify in the associated mountns means
that containers could decide to have their own healer instances with
their own policies.

It had also occurred to me that wouldn't work so well for a
PrivateMounts=yes systemd service that also gets to mount its own xfs
filesystems.  Granted fanotify might not either, but at least this way
we don't have to wind through udev.

> Instead ties this to fanotify which is the right interface for this.
> My suggestion would be to tie this to mount namespaces as that's the
> appropriate object. Fanotify already supports listening for general
> mount/umount events on mount namespaces. So extend it to send filesystem
> creation/destruction events so that a caller may listen on the initial
> mount namespace - where xfs fses can be mounted - you could even make it
> filterable per filesystem type right away.

Hrmm, would that program look something like this?  Please ignore the
weird weakhandle struct, I hastily stapled this together from various
programs.

I'm not that familiar with fanotify, so I'm curious what the rest of you
think of handle_mount_event and main.  In my trivial workstation test it
worked as a POC, but I've not even thrown fstests at it.

--D

#include <errno.h>
#include <err.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/fanotify.h>
#include <sys/types.h>
#include <unistd.h>
#include <linux/mount.h>
#include <sys/syscall.h>
#include <string.h>
#include <sys/wait.h>
#include <limits.h>

struct weakhandle {
	const char		*mntpoint;
};

/* Compute the systemd instance unit name for this mountpoint. */
int
weakhandle_instance_unit_name(
	struct weakhandle	*wh,
	const char		*template,
	char			*unitname,
	size_t			unitnamelen)
{
	FILE			*fp;
	char			*s;
	ssize_t			bytes;
	pid_t			child_pid;
	int			pipe_fds[2];
	int			ret;

	ret = pipe(pipe_fds);
	if (ret)
		return -1;

	child_pid = fork();
	if (child_pid < 0)
		return -1;

	if (!child_pid) {
		/* child process */
		char		*argv[] = {
			"systemd-escape",
			"--template",
			(char *)template,
			"--path",
			(char *)wh->mntpoint,
			NULL,
		};

		ret = dup2(pipe_fds[1], STDOUT_FILENO);
		if (ret < 0) {
			perror(wh->mntpoint);
			goto fail;
		}

		ret = execvp("systemd-escape", argv);
		if (ret)
			perror(wh->mntpoint);

fail:
		exit(EXIT_FAILURE);
	}

	/* parent scrapes the output */
	fp = fdopen(pipe_fds[0], "r");
	s = fgets(unitname, unitnamelen, fp);
	fclose(fp);
	close(pipe_fds[1]);

	waitpid(child_pid, NULL, 0);

	if (!s) {
		errno = ENOENT;
		return -1;
	}

	/* trim off trailing newline */
	bytes = strlen(s);
	if (s[bytes - 1] == '\n')
		s[bytes - 1] = 0;

	return 0;
}

static void start_healer(const char *mntpoint)
{
	struct weakhandle wh = {
		.mntpoint = mntpoint,
	};
	char svcname[PATH_MAX];
	pid_t child_pid;
	int child_status;
	int ret;

	ret = weakhandle_instance_unit_name(&wh, "xfs_healer@.service",
			svcname, PATH_MAX);
	if (ret) {
		perror("whiun!");
		return;
	}


	printf("systemctl start xfs_healer@%s\n", svcname);

	child_pid = fork();
	if (child_pid < 0) {
		perror(mntpoint);
		return;
	}
	if (!child_pid) {
		/* child starts the process */
		char		*argv[] = {
			"systemctl",
			"start",
			"--no-block",
			svcname,
			NULL,
		};

		ret = execvp("systemctl", argv);
		if (ret)
			perror("systemctl");

		exit(EXIT_FAILURE);
	}

	/* parent waits for process */
	waitpid(child_pid, &child_status, 0);

	if (WIFEXITED(child_status) && WEXITSTATUS(child_status) == 0) {
		printf("%s: healer started\n", mntpoint);
		fflush(stdout);
		return;
	}

	fprintf(stderr, "%s: could not start healer\n", mntpoint);
}

static void find_mount(const struct fanotify_event_info_mnt *mnt,
		int mnt_ns_fd)
{
	struct mnt_id_req req = {
		.size = sizeof(req),
		.mnt_id = mnt->mnt_id,
		.mnt_ns_fd = mnt_ns_fd,
		.param = STATMOUNT_FS_TYPE | STATMOUNT_MNT_POINT,
	};
	size_t smbuf_size = sizeof(struct statmount) + 4096;
	struct statmount *smbuf = alloca(smbuf_size);
	int ret;

	ret = syscall(SYS_statmount, &req, smbuf, smbuf_size, 0);
	if (ret) {
		perror("statmount");
		return;
	}

	printf("mount: id 0x%llx fstype %s mountpoint %s\n", mnt->mnt_id,
			smbuf->str + smbuf->fs_type,
			smbuf->str + smbuf->mnt_point);

	if (!strcmp(smbuf->str + smbuf->fs_type, "xfs"))
		start_healer(smbuf->str + smbuf->mnt_point);
}

static void handle_mount_event(const struct fanotify_event_metadata *event,
		int mnt_ns_fd)
{
	const struct fanotify_event_info_header *info;
	const struct fanotify_event_info_mnt *mnt;
	int off;

	if (event->fd != FAN_NOFD) {
		printf("Unexpected fd (!= FAN_NOFD)\n");
		return;
	}

	switch (event->mask) {
	case FAN_MNT_ATTACH:
		printf("FAN_MNT_ATTACH (len=%d)\n", event->event_len);
		break;
	case FAN_MNT_DETACH:
		printf("FAN_MNT_DETACH (len=%d)\n", event->event_len);
		break;
	}

	for (off = sizeof(*event) ; off < event->event_len;
	     off += info->len) {
		info = (struct fanotify_event_info_header *)
			((char *) event + off);

		switch (info->info_type) {
		case FAN_EVENT_INFO_TYPE_MNT:
			mnt = (struct fanotify_event_info_mnt *) info;

			printf("\tGeneric Mount Record: len=%d\n",
			       mnt->hdr.len);
			printf("\tmnt_id: %llx\n", mnt->mnt_id);
			find_mount(mnt, mnt_ns_fd);
			break;

		default:
			printf("\tUnknown info type=%d len=%d:\n",
			       info->info_type, info->len);
		}
	}
}

static void handle_notifications(char *buffer, int len, int mnt_ns_fd)
{
	struct fanotify_event_metadata *event =
		(struct fanotify_event_metadata *) buffer;

	for (; FAN_EVENT_OK(event, len); event = FAN_EVENT_NEXT(event, len)) {

		switch (event->mask) {
		case FAN_MNT_ATTACH:
		case FAN_MNT_DETACH:
			handle_mount_event(event, mnt_ns_fd);
			break;
		default:
			printf("unexpected FAN MARK: %llx\n",
					(unsigned long long)event->mask);
			break;
		}

		printf("---\n\n");
		fflush(stdout);
	}
}

int main(int argc, char *argv[])
{
	char buffer[BUFSIZ];
	int mnt_ns_fd;
	int fan_fd;
	int ret;

	mnt_ns_fd = open("/proc/self/ns/mnt", O_RDONLY);
	if (mnt_ns_fd < 0) {
		perror("/proc/self/ns/mnt");
		return -1;
	}

	fan_fd = fanotify_init(FAN_REPORT_MNT, O_RDONLY);
	if (fan_fd < 0) {
		perror("fanotify_init");
		return -1;
	}

	ret = fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_MNTNS,
			FAN_MNT_ATTACH | FAN_MNT_DETACH, mnt_ns_fd, NULL);
	if (ret) {
		perror("fanotify_mark");
		return -1;
	}

	printf("fanotify active\n");
	fflush(stdout);

	while (1) {
		int n = read(fan_fd, buffer, BUFSIZ);

		if (n < 0)
			errx(1, "read");

		handle_notifications(buffer, n, mnt_ns_fd);
	}

	return 0;
}

